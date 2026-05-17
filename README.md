# AHB Verification IP (AHB_VIP)

## 📌 Overview
This repository contains a Verification Intellectual Property (VIP) for the AMBA Advanced High-performance Bus (AHB) protocol. It provides a robust, scalable environment for verifying AHB-compliant designs (Masters, Slaves, or Interconnects) using [SystemVerilog / UVM].

## 📂 Directory Structure
The workspace is organized into standard ASIC design and verification directories:

* **`rtl/`**: Contains the Design Under Test (DUT) and any associated RTL components.
* **`tb/`**: The main testbench environment. Includes all verification components (Agents, Monitors, Drivers, Sequencers, Scoreboards, and Top-level Environment).
* **`testcase/`**: Contains specific test scenarios, sequences, and virtual sequences designed to hit different coverage points and edge cases.
* **`sim/`**: Scripts and Makefiles for compiling, running simulations, and generating coverage reports.

## 🛠️ Prerequisites
To compile and run this project, you will need the following tools set up in your Linux environment:
* An HDL Simulator (e.g., QuestaSim, VCS, or Verilator)
* Make utility
* [SystemVerilog / UVM 1.2 Library]

## 🚀 Getting Started

### 1. Clone the repository
```bash
git clone git@github.com:hieufetel/AHB_VIP.git
cd AHB_VIP
