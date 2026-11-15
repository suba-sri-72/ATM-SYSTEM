<img width="505" height="610" alt="Screenshot 2026-11-15 142841" src="https://github.com/user-attachments/assets/333d9e7d-7da2-451e-bb4e-d2d25ab6a030" />
<img width="662" height="412" alt="Screenshot 2026-11-15 142857" src="https://github.com/user-attachments/assets/0e56ec48-5d12-4bb3-81fb-93f67b84ec12" />
<img width="1532" height="587" alt="Screenshot 2026-11-15 143422" src="https://github.com/user-attachments/assets/11817282-8787-487f-9ce0-43cab46b2475" />
<img width="1452" height="571" alt="Screenshot 2026-11-15 143120" src="https://github.com/user-attachments/assets/6cdcdcf1-421b-4258-bd9f-cf700f0b30a6" />
# ATM-SYSTEM
ATM System Design using Verilog HDL with FSM-based transaction control.
# ATM System Design using Verilog HDL

## 📌 Project Overview

This project implements an Automated Teller Machine (ATM) system using Verilog HDL. The design uses a Finite State Machine (FSM) to control different banking operations such as PIN validation, balance enquiry, cash withdrawal, deposit, and transaction cancellation.

## 🎯 Features

- Card insertion detection
- PIN validation
- Balance enquiry
- Cash withdrawal
- Deposit operation
- Insufficient balance detection
- Transaction cancellation
- Account balance update

## ⚙️ Design Specifications

| Parameter | Description |
|---|---|
| HDL | Verilog |
| Architecture | FSM-based design |
| FSM Type | Sequential FSM |
| PIN | 0101 |
| Initial Balance | 9000 |
| Balance Width | 16 bits |
| State Register | 4 bits |
| Clock | Positive edge triggered |
| Reset | Synchronous active-high |

## 🔄 FSM Operations

The ATM controller uses the following states:

- S0 – Idle
- S1 – Card Detection
- S2 – PIN Entry
- S3 – PIN Verification
- S4 – Transaction Selection
- S5 – Balance Enquiry
- S6 – Withdrawal Check
- S7 – Deposit
- S8 – Cancel
- S9 – Insufficient Balance
- S10 – Cash Dispensing

## 🧪 Verification and Test Scenarios

The design is verified using a Verilog testbench.

Test scenarios include:

1. Balance enquiry
2. Successful withdrawal of 2000
3. Insufficient balance withdrawal attempt of 10000
4. Deposit of 1000
5. Incorrect PIN validation
6. Transaction cancellation

## 🛠️ Tools Used

- Verilog HDL
- QuestaSim
- RTL Simulation
- RTL Schematic Analysis

## 📂 Project Files

- `atm.v` – RTL design
- `atm_tb.v` – Testbench
- `atm_schematic.png` – RTL schematic

## 📊 Expected Simulation Results

| Operation | Expected Result |
|---|---:|
| Initial Balance | 9000 |
| Balance Enquiry | 9000 |
| Withdrawal | 2000 |
| Updated Balance | 7000 |
| Insufficient Withdrawal | No cash dispensed |
| Deposit | 1000 |
| Updated Balance | 8000 |

## 📚 Learning Outcomes

- Understanding FSM-based RTL design
- Implementing sequential logic
- Designing transaction control logic
- Performing arithmetic operations in Verilog
- Developing testbenches
- Debugging and verifying RTL designs

## 👩‍💻 Author

Suba Sri

**GitHub Repository:** https://github.com/suba-sri-72/ATM-System-Verilog
