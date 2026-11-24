import assert from 'node:assert/strict';
import { readFile } from 'node:fs/promises';
import { dirname, resolve } from 'node:path';
import { fileURLToPath, pathToFileURL } from 'node:url';
import test from 'node:test';

const __dirname = dirname(fileURLToPath(import.meta.url));
const repoRoot = resolve(__dirname, '../..');
const pluginPath = resolve(repoRoot, '.opencode/plugins/forge-anything.js');
const bootstrapPath = resolve(repoRoot, 'skills/using-forge-anything/SKILL.md');

async function loadPlugin() {
  const mod = await import(pathToFileURL(pluginPath).href + `?cachebust=${Date.now()}-${Math.random()}`);
  const plugin = await mod.ForgeAnythingPlugin({ client: {}, directory: repoRoot });
  return plugin;
}

function transformOf(plugin) {
  const handler = plugin['experimental.chat.messages.transform'];
  assert.equal(typeof handler, 'function', 'plugin must expose experimental.chat.messages.transform');
  return handler;
}

function userMessage(text) {
  return {
    info: { role: 'user' },
    parts: [{ type: 'text', text }],
  };
}

function firstUserText(output) {
  const firstUser = output.messages.find((m) => m.info.role === 'user');
  return firstUser.parts.filter((p) => p.type === 'text').map((p) => p.text).join('\n');
}

test('transform prepends the bootstrap to the first user message', async () => {
  const plugin = await loadPlugin();
  const transform = transformOf(plugin);
  const output = { messages: [userMessage('Let us make a react todo list')] };

  await transform({}, output);

  assert.equal(output.messages.length, 1);
  const text = firstUserText(output);
  assert.match(text, /You have Forge Anything/);
  assert.match(text, /EXTREMELY_IMPORTANT/);
  assert.match(text, /Let us make a react todo list/);
  // Bootstrap comes first, the user prompt stays intact after it.
  assert.ok(text.indexOf('You have Forge Anything') < text.indexOf('Let us make a react todo list'));
});

test('transform does not inject twice on a second call', async () => {
  const plugin = await loadPlugin();
  const transform = transformOf(plugin);
  const output = { messages: [userMessage('Let us make a react todo list')] };

  await transform({}, output);
  const afterFirst = firstUserText(output);
  await transform({}, output);
  const afterSecond = firstUserText(output);

  assert.equal(afterSecond, afterFirst, 'second transform must not duplicate the bootstrap');
  assert.equal((afterSecond.match(/You have Forge Anything/g) || []).length, 1);
});

test('transform leaves messages without a user prompt alone', async () => {
  const plugin = await loadPlugin();
  const transform = transformOf(plugin);
  const output = { messages: [] };
  await transform({}, output);
  assert.equal(output.messages.length, 0);

  const noParts = { messages: [{ info: { role: 'user' }, parts: [] }] };
  await transform({}, noParts);
  assert.equal(noParts.messages[0].parts.length, 0);
});

test('injected bootstrap is the using-forge-anything skill body', async () => {
  const plugin = await loadPlugin();
  const transform = transformOf(plugin);
  const output = { messages: [userMessage('hello')] };
  await transform({}, output);
  const text = firstUserText(output);

  const skill = await readFile(bootstrapPath, 'utf8');
  const body = skill.replace(/^---\n[\s\S]*?\n---\n/, '').trim();
  // A distinctive line from the skill body must survive into the injection.
  const probe = body.split('\n').find((line) => line.trim().length > 40);
  assert.ok(probe, 'skill body has no long line to probe with');
  assert.ok(text.includes(probe.trim()), 'injected bootstrap is not the skill body');
  // Frontmatter must be stripped, not injected.
  assert.doesNotMatch(text, /^description:/m);
});
