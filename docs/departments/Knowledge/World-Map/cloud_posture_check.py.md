node_type: logic-engine
silo: Security
degree: 0
source: Security/skills/cloud-security/scripts/cloud_posture_check.py
# cloud_posture_check.py

## 🧠 Strategic Intelligence
This entity is a **logic-engine** within the **Security** silo. 
It has a connectivity degree of **0**.

## 🔗 Neural Links

### Directing To:
- [[
cloud_posture_check.py--Cloud-Security-Posture-Check

Analyses-IAM-policies-and-cloud-resource-configurations-for-privilege
escalation-paths,-data-exfiltration-risks,-public-exposure,-S3-bucket
misconfigurations,-and-Security-Group-dangerous-inbound-rules.

Supports-AWS-(full),-with-Azure/GCP-stubs-for-future-expansion.

Usage:
----python3-cloud_posture_check.py-policy.json
----python3-cloud_posture_check.py-policy.json---check-privilege-escalation---json
----python3-cloud_posture_check.py-sg.json---check-sg---provider-aws---json
----python3-cloud_posture_check.py-bucket.json---check-s3---severity-modifier-internet-facing

Exit-codes:
----0--No-findings-or-informational-only
----1--High-severity-findings-present
----2--Critical-findings-present
]] (orchestrates | 1.0)
- [[
----Check-AWS-Security-Group-JSON-for-dangerous-inbound-rules.

----Args:
--------sg_json:------------Parsed-Security-Group-JSON-(AWS-DescribeSecurityGroups
----------------------------output-format-or-Terraform-aws_security_group-block).
--------source:-------------Display-name-/-file-path.
--------severity_modifier:--internet-facing-|-regulated-data-|-none.

----Returns:
--------IAMAnalysisResult-populated-with-SG-findings.
----]] (orchestrates | 1.0)
- [[-to-the-specific-IP-ranges-that-require-access.-Use-Security-Group-references-instead-of-CIDRs-where-possible.]] (orchestrates | 1.0)
