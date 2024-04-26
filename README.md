# ns3-mmwave-oran-patches
This project represents a modification of the ns-o-ran-ns3-mmwave project, aimed at transitioning the ns-3 version from 3.33 to 3.41. The source code is derived from the [ns3 repository](https://gitlab.com/nsnam/ns-3-dev), with additional functionalities introduced in both [ns-o-ran-ns3-mmwave](https://github.com/wineslab/ns-o-ran-ns3-mmwave) and [ns3-mmwave](https://github.com/nyuwireless-unipd/ns3-mmwave) repositories applied as patches to the ns3 codebase. These patches futher encompass alterations made to the aforementioned repositories to facilitate migration to ns-3.41.

## Introduction

This tutorial offers guidance on deploying and utilizing the ns-O-RAN Open RAN Simulation Platform alongside a near-RT RIC (Radio Intelligent Controller).

ns-O-RAN merges a functional 4G/5G protocol stack within ns-3 with an O-RAN-compliant E2 interface. This integration empowers data collection and xApp testing functionalities, thereby streamlining the development of AI and ML solutions tailored for Open RAN and 5G/6G ecosystems.

## Setup

The architecture involves setting up ns-O-RAN and integrating it with the Near-RT RIC.

### Near-RT RIC Setup

1. Clone the Colosseum's near-RT RIC repository and navigate to setup scripts.

```
git clone -b ns-o-ran https://github.com/wineslab/colosseum-near-rt-ric
cd colosseum-near-rt-ric/setup-scripts
```

2. Import necessary Docker images, tag them, and launch.

```
./import-wines-images.sh
./setup-ric-bronze.sh
```


3. Verify container status and open terminals for logging and xApp.
```
docker ps
docker logs e2term -f --since=1s 2>&1 | grep gnb:
cd colosseum-near-rt-ric/setup-scripts
./start-xapp-ns-o-ran.sh
```


4. Run xApp logic in the container.

```
cd /home/sample-xapp
./run_xapp.sh
```


### ns-O-RAN Setup

#### Quick Setup

1. Clone the patch repository

```
git clone https://github.com/ronithrnair/ns3-mmwave-oran-patches
```

2. Run the setup script
```
cd ns3-mmwave-oran-patches
./build_ns3_components.sh
```
The script performs all the steps listed in the manual installation

#### Manual Setup

1. Install prerequisites for ns-O-RAN and ns-3 in Ubuntu 20.04 LTS.
```
sudo apt-get update
sudo apt-get install -y build-essential git cmake libsctp-dev autoconf automake libtool bison flex libboost-all-dev g++ python3
```

2. Clone the patch repository

```
git clone https://github.com/ronithrnair/ns3-mmwave-oran-patches
```


3. Clone, apply patch, and install e2Sim software.

```
git clone https://github.com/wineslab/ns-o-ran-e2-sim oran-e2sim
cd oran-e2sim
```
```
git apply --ignore-space-change --ignore-whitespace ../ns3-mmwave-oran-patches/oran-e2sim/oran-e2sim-patch.patch
```
```
cd e2sim/
mkdir build
./build_e2sim.sh 3
cd ../..
```


4. Clone and apply patch to ns3 project for the latest supported commit.

```
git clone https://github.com/nsnam/ns-3-dev-git.git
cd ns-3-dev-git
git checkout 3e98de188d7b5d5a53b04efb28ee60bac4db4cc5
```
```
git apply --ignore-space-change --ignore-whitespace ../ns3-mmwave-oran-patches/mmwave/mmwave-patch.patch
```
5. Clone and integrate ns-O-RAN module into ns3-mmWave project.

```
cd contrib
git clone -b master https://github.com/o-ran-sc/sim-ns3-o-ran-e2 oran-interface
cd oran-interface
```
```
git apply --ignore-space-change --ignore-whitespace ../../../ns3-mmwave-oran-patches/oran-interface/oran-interface-patch.patch
```


6. Configure and build ns-3.
```
cd ../..
./ns3 clean
./ns3 configure --enable-examples --enable-tests
./ns3 build
```


## Usage

### Scenario Zero

Run an example ns-3 scenario named "Scenario Zero", featuring a Non Stand Alone (NSA) 5G setup.
```
./ns3 run scratch/scenario-zero.cc
```

This scenario includes one LTE eNB in the center and four gNBs positioned around it with an inter-site distance of 1000 between the eNB and each gNB.


