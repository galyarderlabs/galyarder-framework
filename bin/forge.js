#!/usr/bin/env node

const { spawn } = require('child_process');
const path = require('path');
const fs = require('fs');

const pkg = JSON.parse(fs.readFileSync(path.join(__dirname, '../package.json'), 'utf8'));
const version = pkg.version;

const args = process.argv.slice(2);
const command = args[0];

const scripts = {
    'scaffold': '../scripts/scaffold-company.sh',
    'deploy': '../scripts/install.sh',
    'smoke': '../scripts/smoke.sh',
    'convert': '../scripts/convert.sh',
    'sync': '../scripts/sync-codex-skills.py'
};

function showHelp() {
    console.log(`
Forge Anything CLI v${version}
Forge anything with AI agents.

Usage:
  forge <command> [options]

Commands:
  scaffold  Initialize a new Forge Anything project
  deploy    Deploy agents to your IDE or global environment
  smoke     Run system integrity checks
  convert   Run conversion engine for different AI platforms
  sync      Synchronize skills with your local environment
  version   Show current Forge Anything version
  help      Show this help message

Examples:
  forge scaffold
  forge deploy --tool gemini
  forge smoke
    `);
}

if (!command || command === 'help' || command === '--help' || command === '-h') {
    showHelp();
    process.exit(0);
}

if (command === 'version' || command === '--version' || command === '-v') {
    console.log(`Forge Anything v${version}`);
    process.exit(0);
}

const scriptPath = scripts[command];

if (!scriptPath) {
    console.error(`[ERR] Unknown command: ${command}`);
    showHelp();
    process.exit(1);
}

const fullPath = path.join(__dirname, scriptPath);
const passThroughArgs = args.slice(1);

// Execute the corresponding shell script
const isPython = scriptPath.endsWith('.py');
const execCmd = isPython ? 'python3' : 'bash';
const execArgs = isPython ? [fullPath, ...passThroughArgs] : [fullPath, ...passThroughArgs];

const child = spawn(execCmd, execArgs, {
    stdio: 'inherit',
    env: process.env
});

child.on('exit', (code) => {
    process.exit(code || 0);
});
