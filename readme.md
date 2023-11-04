# SystemsGenesis_CSAW2023

Welcome to the SystemsGenesis CSAW 2023 AI Hardware Attack Challenge repository!

## Overview

This repository contains the digital designs created by the SystemsGenesys team for the CSAW 2023 AI Hardware Attack Challenge. The challenge focused on creating hardware-based malware using Large Language Models (LLMs), with ChatGPT4 as the chosen LLM.

## Projects

We've developed three different hardware malware projects using SystemVerilog and various techniques:

1. **UART Peripheral Denial-of-Service (DoS) Malware**
   - Location: [Project Folder](/uart_dos)
   - Description: This project features a Denial-of-Service malware targeting a UART peripheral.
   
2. **Wishbone Bus Peripheral Denial-of-Service (DoS) Malware**
   - Location: [Project Folder](/wishbone_dos)
   - Description: This project showcases a Denial-of-Service malware designed for a Wishbone bus peripheral.
   
3. **AES Encryption/Decryption IP Block Information Leakage Malware**
   - Location: [Project Folder](/tree/main/projects/AES)
   - Description: In this project, we've created malware to leak sensitive information (key) from an AES encryption/decryption IP block.

## Prompt Engineering Techniques

We utilized the Chain Of Thought (CoT) technique for prompt engineering and also employed the recipe and persona prompt pattern to interact with the LLM effectively.

## Verification and Testing

To ensure the functionality and security of our designs, we used [EDAplayground](https://www.edaplayground.com/) for testing and verification.

## Repository Structure

- `/ip`: Contains any IP blocks used in reference for each project.
- `/rtl`: Contains the SystemVerilog code for each project.
- `/test`: Includes testbenches for validating project functionality.
- `/simulation`: Stores simulation files.
- `/synthesis`: For synthesis-related files.

## License

All projects in this repository are open source under the [Apache License](LICENSE).

## Getting Started

If you'd like to explore or contribute to our projects, please refer to the respective project folders for detailed instructions on how to use and test them.

Feel free to reach out to us if you have any questions or would like to collaborate!

Happy hacking!

---

**Disclaimer**: This repository is intended for educational and research purposes only. Malicious use of the provided designs is strictly prohibited.

