'use strict'
// dsh-launcher sanity checks for CI: metadata, docs, and the batch script.
// Uses only Node built-ins so CI needs no dependency install.
const fs = require('node:fs')
const path = require('node:path')

const root = path.join(__dirname, '..')
const failures = []

function ok(cond, msg) {
  if (cond) console.log('ok: ' + msg)
  else { console.error('FAIL: ' + msg); failures.push(msg) }
}

// package metadata
const pkg = JSON.parse(fs.readFileSync(path.join(root, 'package.json'), 'utf8'))
ok(/^@[a-z0-9-]+\/[a-z0-9-]+$/.test(pkg.name), 'package name is scoped')
ok(typeof pkg.version === 'string' && pkg.version.length > 0, 'package version is present')
ok(pkg.license === 'BSD-3-Clause', 'license is BSD-3-Clause')

// launcher script
const batPath = path.join(root, 'start-harness.bat')
ok(fs.existsSync(batPath), 'start-harness.bat exists')
const bat = fs.readFileSync(batPath, 'utf8')
ok(bat.trimStart().startsWith('@echo off'), 'script starts with @echo off')
ok(bat.includes('3080'), 'default port 3080 is present')
ok(bat.includes('dsh'), 'script locates the dsh command')
ok(bat.includes('netstat'), 'script detects the listening port')
ok(bat.includes('start ""'), 'script opens the browser')

// Windows batch files must use CRLF line endings
ok(bat.includes('\r\n'), 'batch file uses CRLF line endings')
ok(!/(?<!\r)\n/.test(bat), 'batch file has no bare LF line endings')

// docs
ok(fs.existsSync(path.join(root, 'README.md')), 'README.md exists')
ok(fs.existsSync(path.join(root, 'LICENSE')), 'LICENSE exists')

if (failures.length > 0) {
  console.error('\n' + failures.length + ' check(s) failed')
  process.exit(1)
}
console.log('\nAll launcher checks passed.')
