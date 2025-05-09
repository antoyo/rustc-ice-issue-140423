#!/bin/bash

rustc_path=$(rustup which rustc)
parent=$(dirname $rustc_path)
rustlib_dir=$parent/../lib/rustlib/src/rust

sysroot_dir=my_sysroot
rm -Rf $sysroot_dir

git clone --depth 1 https://github.com/llvm/llvm-project

export RUST_COMPILER_RT_FOR_PROFILER="$(pwd)/llvm-project/compiler-rt"

cp -r $rustlib_dir/library $sysroot_dir

cd $sysroot_dir

export RUSTFLAGS="-Z force-unstable-if-unmarked -Zmir-opt-level=3"
cargo build
