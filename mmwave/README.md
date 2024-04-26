# mmwave Patch

The [ns-o-ran-ns3-mmwave](https://github.com/wineslab/ns-o-ran-ns3-mmwave) project introduced support for an O-RAN compliant E2 interface within the simulation process, building upon the [ns3-mmwave](https://github.com/nyuwireless-unipd/ns3-mmwave) codebase. Originally developed on ns-3.33, this project has not seen subsequent updates. While ns3-mmwave now supports ns-3.38, [ns-3](https://gitlab.com/nsnam/ns-3-dev) has progressed to version 3.41.

This patch file amalgamates the aforementioned functionalities into the ns-3 repository, while simultaneously upgrading the base ns-3 version to 3.41. The code modifications were implemented in two phases: [first upgrading to ns-3.38](https://github.com/adi-012/mmwave3.8-with-wineslab-updates), followed by [upgrading to ns-3.41](https://github.com/bletchley-park/ns3-dev-mmwave).
