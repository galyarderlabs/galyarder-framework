export function buildCliCommandLabel(): string {
  const args = process.argv.slice(2);
  return args.length > 0 ? `galyarder ${args.join(" ")}` : "galyarder";
}
