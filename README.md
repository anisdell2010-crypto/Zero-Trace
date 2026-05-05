# 🛡️ <img src="https://www.kali.org/images/kali-logo.svg" alt="Kali Linux" width="30" height="30" valign="middle"> 🛡️ CoreSanitize Framework v1.0
Advanced Network Hygiene & Privacy Protection (Bash)

![Platform](https://img.shields.io/badge/platform-Kali%20Linux-blue)
![Language](https://img.shields.io/badge/language-Bash-green)
![Version](https://img.shields.io/badge/version-1.0-red)
![License](https://img.shields.io/badge/license-Educational-orange)
CoreSanitize is an educational Linux security toolkit focused on understanding network behavior, wireless interfaces, and system-level security concepts in controlled lab environments.

---

### ⚖️ Legal Disclaimer
**This tool is for EDUCATIONAL and AUTHORIZED PENETRATION TESTING purposes only.**
The developer assumes **NO responsibility** for any misuse or illegal activities performed with this software. Use at your own risk. 🚫⚖️

---

### 🏆 Professional Certifications
- 🎓 **ISC2:** [Certified ISC2 Candidate](https://www.credly.com/badges/20f257e0-af1c-4ff4-8cb4-f2443229b77d/public_url)
- 🎓 **Cisco:** [Introduction to Cybersecurity](https://www.credly.com/badges/287b2ee6-cff8-4d87-ad7c-c494ad518ccf/public_url)
- 🎓 **IBM:** [Cybersecurity Fundamentals](https://www.credly.com/badges/e80a886c-352e-4c89-9374-f1c222fab989/public_url)
-🎓 **Cisco**: [Certified Ethical Hacker](https://www.credly.com/badges/01549b33-84b6-48b4-81af-d7b2ac54e5a6/public_url) 
---
👨‍💻 Developed By
This entire suite, from logic to documentation, is an independent production developed from scratch by Abderaouf Sendid (r4ouf_s). 🛡️💻

Some pictures showing what the tool looks like and how it works:
 <img width="1280" height="953" alt="Capture d’écran 2026-05-04 220548" src="https://github.com/user-attachments/assets/28c763c2-aad4-4228-a81f-50f14129bc0d" />
 <img width="1280" height="963" alt="Capture d’écran 2026-05-04 220708" src="https://github.com/user-attachments/assets/c0b25d7c-4828-4371-8183-2e556ccf61d4" />
 <img width="1280" height="952" alt="Capture d’écran 2026-05-04 220801" src="https://github.com/user-attachments/assets/24e6d9f2-b55c-4cbc-b435-bcc08091effb" />



Requirements Section⚠️: 

📦 Requirements
- Kali Linux
- Bash
- airmon-ng
- macchanger
- iw
- NetworkManager
  
🧠 System Features
Network Privacy Shield: Automates MAC address randomization to prevent hardware tracking and enhance user anonymity during sensitive network research.

Automated Research Environment: Streamlines the transition between managed and specialized diagnostic modes (Monitor Mode), ensuring a controlled environment for wireless signal analysis.

Tunnel Integrity Verification: Features an active detection system for encrypted gateways (VPNs), preventing accidental data leaks by ensuring secure communication paths are operational.

System Hygiene & Sanitization: Implements professional-grade data clearing by flushing volatile memory (RAM) and truncating system logs to protect sensitive operational metadata.

Secure Resource Disposal: Includes a built-in cryptographic erasure function that utilizes high-iteration overwriting to permanently remove the script and prevent unauthorized recovery of the toolkit.

### 🚀 Installation & Deployment

To deploy the **Zero-Trace Suite**, execute the following commands in your terminal. Ensure you have `git` and `bash` installed on your Kali Linux system.
```bash
# Clone the repository
git clone https://github.com/anisdell2010-crypto/CoreSanitize.git
cd CoreSanitize
chmod +x CoreSanitize.sh
sudo ./CoreSanitize.sh
