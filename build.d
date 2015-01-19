#!/usr/bin/rdmd

import std.algorithm;
import std.array;
import std.file;
import std.path;
import std.process;
import std.stdio;

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
    system(cmd);

    // compile to temporary assembly file
    // anything greater than -01 breaks things.  Still trying to figure out why
    cmd = "arm-none-eabi-gdc -c -O1 -nophoboslib -nostdinc -nodefaultlibs -nostdlib -fno-emit-moduleinfo"
          ~ " -S"
          
          // use with -O2 (doesn't work)
//           ~ " -fno-section-anchors -fno-tree-vrp -fno-optimize-sibling-calls -fno-reorder-blocks -fno-rerun-cse-after-loop"
//           ~ " -fno-inline-small-functions -fno-expensive-optimizations -fno-gcse -fno-cse-follow-jumps"
          
          // use with -O1 in an attempt to improve optimization
          ~ " -faggressive-loop-optimizations -ftree-pre -ftree-switch-conversion -ftree-tail-merge"
          ~ " -fschedule-insns2 -fstrict-aliasing -fthread-jumps -ftree-builtin-call-dce"
          ~ " -foptimize-strlen -fpeephole2 -freorder-functions"  
          ~ " -fhoist-adjacent-loads -fipa-cp -fipa-sra"
          ~ " -fisolate-erroneous-paths-dereference -fdevirtualize -fdevirtualize-speculatively"
          ~ " -fcaller-saves -fcrossjumping"
          ~ " -falign-functions -falign-jumps -falign-labels -falign-loops"
          
          // Adding any one of these seems to cause problems with -O1
          // ~ " -frerun-cse-after-loop freorder-blocks -foptimize-sibling-calls -ftree-vrp -fexpensive-optimizations"
          // ~ " -finline-small-functions -fgcse -fcse-follow-jumps"
          
          
          // -ffunction-sections breaks things.  Still trying to figure out why
          //~ " -ffunction-sections"
          ~ " -fdata-sections"  
          ~ " " ~ sourceDir.dirEntries("*.d", SpanMode.depth).map!"a.name".join(" ")
          ~ " -o " ~ assemblyFile1;                  
            
    writeln(cmd);
    system(cmd);
    
    // compensate for GCC bug 192: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=192
    cmd = `sed -e 's/^\(\.LC[0-9]*\)\(\:\)/\.section .rodata\1\n\1\2/g' ` ~ assemblyFile1 ~ " >" ~ assemblyFile2;
    //cmd = "cp " ~ assemblyFile1 ~ " " ~ assemblyFile2;
    writeln(cmd);
    system(cmd);
    
    // compile new assembly file
    cmd = "arm-none-eabi-as " ~ assemblyFile2 ~ " -o " ~ objectFile;
    writeln(cmd);
    system(cmd);
    
    // link, creating executable
    cmd = "arm-none-eabi-ld " ~ objectFile ~ " -Tsource/linker/linker.ld --gc-sections -o " ~ outputFile;
    writeln(cmd);
    system(cmd);
    
    // display the size
    system("arm-none-eabi-size " ~ outputFile);
}