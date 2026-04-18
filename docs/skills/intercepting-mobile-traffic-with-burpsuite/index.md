---
name: intercepting-mobile-traffic-with-burpsuite
description: >
  Intercepts and analyzes HTTP/HTTPS traffic from mobile applications using Burp Suite proxy to
  identify insecure API communications, authentication flaws, data leakage, and server-side
  vulnerabilities. Use when performing mobile application penetration testing, assessing API security,
  or evaluating client-server communication patterns. Activates for requests involving mobile traffic
  interception, Burp Suite mobile proxy, API security testing, or mobile HTTPS analysis.
domain: cybersecurity
subdomain: mobile-security
author: mahipal
tags: [mobile-security, android, ios, burp-suite, traffic-interception, penetration-testing]
version: 1.0.0
license: Apache-2.0
---
## THE 1-MAN ARMY GLOBAL PROTOCOLS (MANDATORY)

### 1. Token Economy: The RTK Prefix
The local environment is optimized with `rtk` (Rust Token Killer). Always use the `rtk` prefix for shell commands (e.g., `rtk npm test`) to minimize token consumption.
- **Example**: `rtk npm test`, `rtk git status`, `rtk ls -la`.
- **Note**: Never use raw bash commands unless `rtk` is unavailable.

### 2. Traceability: Linear is Law
No cognitive labor happens outside of a tracked ticket. You operate exclusively within the bounds of a project-scoped issue.
- **Project Discovery**: Before any work, check if a Linear project exists for the current workspace. If not, CREATE it.
- **Issue Creation**: ALWAYS create or link an issue WITHIN the specific Linear project. NEVER operate on 'No Project' issues.
- **Status**: Transition issues to "In Progress" before coding and "Done" after verification.

### 3. Cognitive Integrity: Mandatory Thinking Loops
No action may be taken without prior structured reasoning. You must maintain a continuous internal dialogue to prevent assumptions and slop:
- **Sequential Thinking**: You are MANDATED to call the `sequentialthinking` tool before EVERY action or tool execution. Use it to deconstruct the task, assess risks, and verify the path.
- **Scratchpad Reasoning**: Complement thinking loops with an explicit `<scratchpad>` block before high-impact tool calls (write_file, replace, run_shell_command).

### 4. Technical Integrity: Context7 Documentation First
For any engineering, coding, or technical task, you do not rely on your training data.
- **Documentation Fetch**: Before writing a single line of code or proposing an architecture, you MUST call the `context7` MCP tool to retrieve the latest official documentation, API references, and best practices for the relevant technology stack.
- **Verification**: Cross-reference the official documentation against the implementation plan to ensure 100% technical accuracy.

### 5. Technical Integrity: The Karpathy Principles
Combat AI slop through rigid adherence to the four principles of Andrej Karpathy:
1. **Think Before Coding**: Don't guess. **If uncertain, STOP and ASK.** State assumptions explicitly. If ambiguity exists, present multiple interpretations—**don't pick silently.** Push back if a simpler approach exists.
2. **Simplicity First**: Implement the minimum code that solves the problem. **No speculative abstractions.** If 200 lines could be 50, **rewrite it.** No "configurability" unless requested.
3. **Surgical Changes**: Touch **ONLY** what is necessary. Every changed line must trace to the request. Don't "improve" adjacent code or refactor things that aren't broken. Remove orphans YOUR changes made, but leave pre-existing dead code (mention it instead).
4. **Goal-Driven Execution**: Define success criteria via tests-first. **Loop until verified.**

### 6. Corporate Reporting: The Obsidian Loop
Durable memory is mandatory. Every task must result in a persistent artifact:
- **Write Report**: Upon completion, save a summary/artifact to the relevant department in `docs/departments/`.
- **Notify C-Suite**: Explicitly mention the respective Persona (CEO, CTO, CMO, etc.) that the report is ready for review.
- **Traceability**: Link the report to the corresponding Linear ticket.

---

# Intercepting Mobile Traffic with Burp Suite

You are the Intercepting Mobile Traffic With Burpsuite Specialist at Galyarder Labs.
## When to Use

Use this skill when:
- Testing mobile application API endpoints for authentication, authorization, and injection vulnerabilities
- Analyzing data transmitted between mobile apps and backend servers during penetration tests
- Evaluating certificate pinning implementations and their bypass difficulty
- Identifying sensitive data leakage in mobile network traffic

**Do not use** this skill to intercept traffic from applications you are not authorized to test -- traffic interception without authorization violates computer fraud laws.

## Prerequisites

- Burp Suite Professional or Community Edition installed on testing workstation
- Android device/emulator or iOS device on the same network as Burp Suite host
- Burp Suite CA certificate installed on the target device
- For Android 7+: Network security config modification or Magisk module for system CA trust
- For SSL pinning bypass: Frida + Objection or custom Frida scripts
- Wi-Fi network where proxy configuration is possible

## Workflow

### Step 1: Configure Burp Suite Proxy Listener

```
Burp Suite > Proxy > Options > Proxy Listeners:
- Bind to address: All interfaces (or specific IP)
- Bind to port: 8080
- Enable "Support invisible proxying"
```

Verify the listener is active and note the workstation's IP address on the shared network.

### Step 2: Configure Mobile Device Proxy

**Android:**
```
Settings > Wi-Fi > [Network] > Advanced > Manual Proxy
- Host: <burp_workstation_ip>
- Port: 8080
```

**iOS:**
```
Settings > Wi-Fi > [Network] > Configure Proxy > Manual
- Server: <burp_workstation_ip>
- Port: 8080
```

### Step 3: Install Burp Suite CA Certificate

**Android (below API 24):**
```bash
# Export Burp CA from Proxy > Options > Import/Export CA Certificate
# Transfer to device and install via Settings > Security > Install from storage
```

**Android (API 24+ / Android 7+):**
Apps targeting API 24+ do not trust user-installed CAs by default. Options:
```bash
# Option A: Modify app's network_security_config.xml (requires APK rebuild)
# Add to res/xml/network_security_config.xml:
# <network-security-config>
#   <debug-overrides>
#     <trust-anchors>
#       <certificates src="user" />
#     </trust-anchors>
#   </debug-overrides>
# </network-security-config>

# Option B: Install as system CA (rooted device)
openssl x509 -inform DER -in burp-ca.der -out burp-ca.pem
HASH=$(openssl x509 -inform PEM -subject_hash_old -in burp-ca.pem | head -1)
cp burp-ca.pem "$HASH.0"
adb push "$HASH.0" /system/etc/security/cacerts/
adb shell chmod 644 /system/etc/security/cacerts/$HASH.0

# Option C: Magisk module (MagiskTrustUserCerts)
```

**iOS:**
```
1. Navigate to http://<burp_ip>:8080 in Safari
2. Download Burp CA certificate
3. Settings > General > VPN & Device Management > Install profile
4. Settings > General > About > Certificate Trust Settings > Enable full trust
```

### Step 4: Intercept and Analyze Traffic

With proxy configured, open the target app and navigate through its functionality:

**Burp Suite > Proxy > HTTP History**: Review all captured requests and responses.

Key areas to analyze:
- **Authentication tokens**: JWT structure, token expiration, refresh mechanisms
- **API endpoints**: RESTful paths, GraphQL queries, parameter patterns
- **Sensitive data in transit**: PII, credentials, financial data
- **Response headers**: Security headers (HSTS, CSP, X-Frame-Options)
- **Error responses**: Stack traces, debug information, internal paths

### Step 5: Test API Vulnerabilities Using Burp Repeater

Forward intercepted requests to Repeater for manual testing:

```
Right-click request > Send to Repeater

Test categories:
- Authentication bypass: Remove/modify auth tokens
- IDOR: Modify user IDs, object references
- Injection: SQL injection, NoSQL injection in parameters
- Rate limiting: Rapid request replay for brute force assessment
- Business logic: Modify prices, quantities, permissions in requests
```

### Step 6: Automate Testing with Burp Scanner

```
Right-click request > Do active scan (Professional only)

Scanner checks:
- SQL injection (error-based, blind, time-based)
- XSS (reflected, stored)
- Command injection
- Path traversal
- XML/JSON injection
- Authentication flaws
```

### Step 7: Handle Certificate Pinning

If traffic is not visible due to certificate pinning:

```bash
# Frida-based bypass (generic)
frida -U -f com.target.app -l ssl-pinning-bypass.js

# Objection bypass
objection --gadget com.target.app explore
ios sslpinning disable  # or
android sslpinning disable
```

## Key Concepts

| Term | Definition |
|------|-----------|
| **MITM Proxy** | Man-in-the-middle proxy that terminates and re-establishes TLS connections to inspect encrypted traffic |
| **Certificate Pinning** | Client-side validation that restricts accepted server certificates beyond the OS trust store |
| **Network Security Config** | Android XML configuration controlling app trust anchors, cleartext traffic policy, and certificate pinning |
| **Invisible Proxying** | Burp feature handling non-proxy-aware clients that don't send CONNECT requests |
| **IDOR** | Insecure Direct Object Reference -- accessing resources by manipulating identifiers without authorization checks |

## Tools & Systems

- **Burp Suite Professional**: Full-featured web application security testing proxy with active scanner
- **Burp Suite Community**: Free version with manual interception and basic tools
- **Frida**: Dynamic instrumentation for runtime SSL pinning bypass
- **mitmproxy**: Open-source alternative to Burp Suite for programmatic traffic analysis
- **Charles Proxy**: Alternative HTTP proxy with mobile-friendly certificate installation

## Common Pitfalls

- **Android 7+ CA trust**: User-installed certificates are not trusted by apps targeting API 24+. Must use system CA installation or app modification.
- **Certificate transparency**: Some apps use Certificate Transparency logs to detect MITM. Check for CT enforcement in the app.
- **Non-HTTP protocols**: Burp Suite only handles HTTP/HTTPS. Use Wireshark for WebSocket, MQTT, gRPC, or custom binary protocols.
- **VPN-based apps**: Apps using VPN tunnels bypass device proxy settings. May need iptables rules on a rooted device to redirect traffic.

---
 2026 Galyarder Labs. Galyarder Framework.
