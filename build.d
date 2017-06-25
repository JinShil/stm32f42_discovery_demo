#!/usr/bin/rdmd

import std.algorithm;
import std.array;
import std.file;
import std.path;
import std.process;
import std.stdio;

void run(string cmd)
{
    auto result = executeShell(cmd);
    writeln(result.output);
}

void main(string[] args)
{
    auto sourceDir = "source";
    auto binaryDir = "binary";
    auto assemblyFile1 = buildPath(binaryDir, "firmware_temp.s");
    auto assemblyFile2 = buildPath(binaryDir, "firmware.s");
    auto objectFile = buildPath(binaryDir, "firmware.o");
    auto outputFile = buildPath(binaryDir, "firmware");
    
    // Create any directories that may not exist
    if (!binaryDir.exists())
    {
        mkdir(binaryDir);
    }
    
    // remove any intermediate files
    string cmd = "rm -f " ~ binaryDir ~ "/*";
    run(cmd);

	string sourceFiles = sourceDir
		.dirEntries("*.d", SpanMode.depth)
		.filter!(a => !a.name.startsWith("source/runtime")) // runtime will be imported automatically
		.map!"a.name"
		.join(" ");

	
    // compile to temporary assembly file
    cmd = "arm-none-eabi-gdc -c -O3 -nophoboslib -nostdinc -nodefaultlibs -nostdlib -fno-emit-moduleinfo"
          ~ " -mthumb -mcpu=cortex-m4"
          ~ " -Iruntime -Immio"
          ~ " -S"
          ~ " -Isource/runtime" // to import runtime automatically
          ~ " -fno-bounds-check -fno-invariants -fno-in -fno-out" // -fno-assert gives me a broken binary
          
          // section anchors with -fdata-sections and --gc-sections causes problems
          // http://forum.dlang.org/post/yjhogkcbegpsrxjkrfmh@forum.dlang.org
          //~ " -fno-section-anchors" 
          
          //~ " -fno-tree-vrp -fno-optimize-sibling-calls -fno-reorder-blocks -fno-rerun-cse-after-loop"
          //~ " -fno-expensive-optimizations"
          //~ " -fno-gcse -fno-cse-follow-jumps"
          //~ " -fno-reorder-blocks-and-partition -fno-schedule-insns -fno-ipa-cp-clone"
          //~ " -fno-tree-loop-distribute-patterns"
          //~ " -fno-inline-functions" 
          //~ " -fno-inline-small-functions"
          
          
          ~ " -ffunction-sections"
          ~ " -fdata-sections" 
          
          ~ " " ~ sourceFiles
          
          ~ " -o " ~ assemblyFile1;                  
            
    writeln(cmd);
    run(cmd);
    
    // compensate for GCC bug 192: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=192
    cmd = `sed -e 's/^\(\.LC[0-9]*\)\(\:\)/\.section .rodata\1\n\1\2/g' ` ~ assemblyFile1 ~ " >" ~ assemblyFile2;
    //cmd = "cp " ~ assemblyFile1 ~ " " ~ assemblyFile2;
    writeln(cmd);
    run(cmd);
    
    // compile new assembly file
    cmd = "arm-none-eabi-as " ~ assemblyFile2 ~ " -o " ~ objectFile;
    writeln(cmd);
    run(cmd);
    
    // link, creating executable
    cmd = "arm-none-eabi-ld " ~ objectFile ~ " -Tlinker/linker.ld --gc-sections -o " ~ outputFile;
    writeln(cmd);
    run(cmd);
    
    // display the size
    run("arm-none-eabi-size " ~ outputFile);
}
