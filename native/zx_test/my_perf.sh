cd /home/SEAL/SEAL/native/zx_test/
# cmake -DCMAKE_BUILD_TYPE=Debug .
make -j32
cd bin/
# perf record -e cpu-clock --call-graph dwarf -g ./01_ckks_basics
perf record --call-graph dwarf -g ./zx_sealexamples
perf script -i perf.data &> perf.unfold
cd FlameGraph/
./stackcollapse-perf.pl ../perf.unfold &> ../perf.folded
./flamegraph.pl ../perf.folded > ../perf.svg