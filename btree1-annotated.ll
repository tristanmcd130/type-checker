; ModuleID = 'btree1.c'
source_filename = "btree1.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.node = type { ptr, ptr, ptr, i8, i64, i64, ptr }
%struct.record = type { i64, ptr, i64, i64 }
%struct.timeval = type { i64, i64 }
%struct.element = type { i64, i64, i64, [40 x i8] }

@allocator_stat = dso_local global i64 0, align 8, !sec !{!"private"}
@order = dso_local global i64 6, align 8, !sec !{!"private"}
@queue = dso_local global ptr null, align 8, !sec !{!"private"}
@.str = private unnamed_addr constant [77 x i8] c"bpt version %s -- Copyright (c) 2018  Amittai Aviram http://www.amittai.com\0A\00", align 1, !sec !{!"public"}
@.str.1 = private unnamed_addr constant [7 x i8] c"1.16.1\00", align 1, !sec !{!"public"}
@.str.2 = private unnamed_addr constant [193 x i8] c"This program comes with ABSOLUTELY NO WARRANTY.\0AThis is free software, and you are welcome to redistribute it\0Aunder certain conditions.\0APlease see the headnote in the source code for details.\0A\00", align 1, !sec !{!"public"}
@.str.3 = private unnamed_addr constant [23 x i8] c"B+ Tree of Order %ld.\0A\00", align 1, !sec !{!"public"}
@.str.4 = private unnamed_addr constant [182 x i8] c"Following Silberschatz, Korth, Sidarshan, Database Concepts, 5th ed.\0A\0ATo build a B+ tree of a different order, start again and enter the order\0Aas an integer argument:  bpt <order>  \00", align 1, !sec !{!"public"}
@.str.5 = private unnamed_addr constant [22 x i8] c"(%d <= order <= %d).\0A\00", align 1, !sec !{!"public"}
@.str.6 = private unnamed_addr constant [149 x i8] c"To start with input from a file of newline-delimited integers, \0Astart again and enter the order followed by the filename:\0Abpt <order> <inputfile> .\0A\00", align 1, !sec !{!"public"}
@.str.7 = private unnamed_addr constant [776 x i8] c"Enter any of the following commands after the prompt > :\0A\09i <k>  -- Insert <k> (an integer) as both key and value).\0A\09i <k> <v> -- Insert the value <v> (an integer) as the value of key <k> (an integer).\0A\09f <k>  -- Find the value under key <k>.\0A\09p <k> -- Pruint64_t the path from the root to key k and its associated value.\0A\09r <k1> <k2> -- Pruint64_t the keys and values found in the range [<k1>, <k2>\0A\09d <k>  -- Delete key <k> and its associated value.\0A\09x -- Destroy the whole tree.  Start again with an empty tree of the same order.\0A\09t -- Pruint64_t the B+ tree.\0A\09l -- Pruint64_t the keys of the leaves (bottom row of the tree).\0A\09v -- Toggle output of pointer addresses (\22verbose\22) in tree and leaves.\0A\09q -- Quit. (Or use Ctl-D or Ctl-C.)\0A\09? -- Pruint64_t this help message.\0A\00", align 1, !sec !{!"public"}
@.str.8 = private unnamed_addr constant [24 x i8] c"Usage: ./bpt [<order>]\0A\00", align 1, !sec !{!"public"}
@.str.9 = private unnamed_addr constant [28 x i8] c"\09where %d <= order <= %d .\0A\00", align 1, !sec !{!"public"}
@.str.10 = private unnamed_addr constant [13 x i8] c"Empty tree.\0A\00", align 1, !sec !{!"public"}
@.str.11 = private unnamed_addr constant [5 x i8] c"%ld \00", align 1, !sec !{!"public"}
@.str.12 = private unnamed_addr constant [4 x i8] c" | \00", align 1, !sec !{!"public"}
@.str.13 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1, !sec !{!"public"}
@.str.14 = private unnamed_addr constant [3 x i8] c"| \00", align 1, !sec !{!"public"}
@.str.15 = private unnamed_addr constant [33 x i8] c"Record not found under key %ld.\0A\00", align 1, !sec !{!"public"}
@.str.16 = private unnamed_addr constant [37 x i8] c"Record at %p -- key %ld, value %ld.\0A\00", align 1, !sec !{!"public"}
@.str.17 = private unnamed_addr constant [13 x i8] c"None found.\0A\00", align 1, !sec !{!"public"}
@.str.18 = private unnamed_addr constant [37 x i8] c"Key: %ld   Location: %p  Value: %ld\0A\00", align 1, !sec !{!"public"}
@free_nodes = dso_local global ptr null, align 8, !sec !{!"private"}
@stderr = external global ptr, align 8, !sec !{!"public"}
@.str.19 = private unnamed_addr constant [30 x i8] c"Failed to allocate memory...\0A\00", align 1, !sec !{!"public"}
@free_recs = dso_local global ptr null, align 8, !sec !{!"private"}
@.str.20 = private unnamed_addr constant [17 x i8] c"Record creation.\00", align 1, !sec !{!"public"}
@.str.21 = private unnamed_addr constant [15 x i8] c"Node creation.\00", align 1, !sec !{!"public"}
@.str.22 = private unnamed_addr constant [21 x i8] c"New node keys array.\00", align 1, !sec !{!"public"}
@.str.23 = private unnamed_addr constant [25 x i8] c"New node pointers array.\00", align 1, !sec !{!"public"}
@.str.24 = private unnamed_addr constant [22 x i8] c"Temporary keys array.\00", align 1, !sec !{!"public"}
@.str.25 = private unnamed_addr constant [26 x i8] c"Temporary pointers array.\00", align 1, !sec !{!"public"}
@.str.26 = private unnamed_addr constant [46 x i8] c"Temporary pointers array for splitting nodes.\00", align 1, !sec !{!"public"}
@.str.27 = private unnamed_addr constant [42 x i8] c"Temporary keys array for splitting nodes.\00", align 1, !sec !{!"public"}
@.str.28 = private unnamed_addr constant [51 x i8] c"Search for nonexistent pointer to node in parent.\0A\00", align 1, !sec !{!"public"}
@.str.29 = private unnamed_addr constant [13 x i8] c"Node:  %#lx\0A\00", align 1, !sec !{!"public"}
@x = internal global [3 x i64] [i64 13070, i64 43981, i64 4660], align 16, !sec !{!"private"}
@a = internal global [3 x i64] [i64 58989, i64 57068, i64 5], align 16, !sec !{!"private"}
@c = internal global i64 11, align 8, !sec !{!"private"}
@.str.30 = private unnamed_addr constant [28 x i8] c"Failed to allocate memory.\0A\00", align 1, !sec !{!"public"}
@.str.31 = private unnamed_addr constant [15 x i8] c"Allocated %ld\0A\00", align 1, !sec !{!"public"}
@.str.32 = private unnamed_addr constant [21 x i8] c"BTree Elements: %zu\0A\00", align 1, !sec !{!"public"}
@.str.33 = private unnamed_addr constant [19 x i8] c"Btree Fanout: %zu\0A\00", align 1, !sec !{!"public"}
@.str.34 = private unnamed_addr constant [19 x i8] c"Allocator: %zu MB\0A\00", align 1, !sec !{!"public"}
@.str.35 = private unnamed_addr constant [32 x i8] c"got %zu matches in %zu seconds\0A\00", align 1, !sec !{!"public"}
@.str.36 = private unnamed_addr constant [17 x i8] c"Experiment DONE\0A\00", align 1, !sec !{!"public"}
@.str.37 = private unnamed_addr constant [8 x i8] c"ENOMEM\0A\00", align 1, !sec !{!"public"}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @license_notice() #0 !sec !{!"void", !"public", !{}} {
entry:                                            ; !sec !{!"public"}
  %call = call i32 (ptr, ...) @printf(ptr noundef @.str, ptr noundef @.str.1), !sec !{!"call", !"public", !{!"public", !"public"}}
  %call1 = call i32 (ptr, ...) @printf(ptr noundef @.str.2), !sec !{!"call", !"public", !{!"public"}}
  ret void
}

;? printf
;? Purpose: System output function
;? Min-PC: public
;? Rationale: Standard I/O function, callable from public contexts. Arguments are declassified
;? before passing if they contain private data.
declare !sec !{!"public", !"public", !{!"public", !"public"}} i32 @printf(ptr noundef, ...) #1

; Declassify function for i64 values
define i64 @declassify.i64(i64 noundef %0) #2 !sec !{!"public", !"public", !{!"private"}} {
entry:                                            ; !sec !{!"public"}
  ret i64 %0, !sec !{!"public"}
}

; Declassify function for ptr values
define ptr @declassify.ptr(ptr noundef %0) #2 !sec !{!"public", !"public", !{!"private"}} {
entry:                                            ; !sec !{!"public"}
  ret ptr %0, !sec !{!"public"}
}

; Declassify function for i1 values
define i1 @declassify.i1(i1 noundef %0) #2 !sec !{!"public", !"public", !{!"private"}} {
entry:                                            ; !sec !{!"public"}
  ret i1 %0, !sec !{!"public"}
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @usage_1() #0 !sec !{!"void", !"public", !{}} {
entry:                                            ; !sec !{!"public"}
  %0 = load i64, ptr @order, align 8, !sec !{!"private", !"private"}
  %public.0 = call i64 @declassify.i64(i64 noundef %0), !sec !{!"declassify", !"private", !"public"}
  %call = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i64 noundef %public.0), !sec !{!"call", !"public", !{!"public", !"public"}}
  %call1 = call i32 (ptr, ...) @printf(ptr noundef @.str.4), !sec !{!"call", !"public", !{!"public"}}
  %call2 = call i32 (ptr, ...) @printf(ptr noundef @.str.5, i32 noundef 3, i32 noundef 20), !sec !{!"call", !"public", !{!"public", !"public", !"public"}}
  %call3 = call i32 (ptr, ...) @printf(ptr noundef @.str.6), !sec !{!"call", !"public", !{!"public"}}
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @usage_2() #0 !sec !{!"void", !"public", !{}} {
entry:                                            ; !sec !{!"public"}
  %call = call i32 (ptr, ...) @printf(ptr noundef @.str.7), !sec !{!"call", !"public", !{!"public"}}
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @usage_3() #0 !sec !{!"void", !"public", !{}} {
entry:                                            ; !sec !{!"public"}
  %call = call i32 (ptr, ...) @printf(ptr noundef @.str.8), !sec !{!"call", !"public", !{!"public"}}
  %call1 = call i32 (ptr, ...) @printf(ptr noundef @.str.9, i32 noundef 3, i32 noundef 20), !sec !{!"call", !"public", !{!"public", !"public", !"public"}}
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @enqueue(ptr noundef %new_node) #0 !sec !{!"void", !"public", !{!"private"}} {
entry:                                            ; !sec !{!"private"}
  %new_node.addr = alloca ptr, align 8, !sec !{!"private"}
  %c = alloca ptr, align 8, !sec !{!"private"}
  store ptr %new_node, ptr %new_node.addr, align 8, !sec !{!"private", !"private"}
  %0 = load ptr, ptr @queue, align 8, !sec !{!"private", !"private"}
  %cmp = icmp eq ptr %0, null, !sec !{!"private"}
  br i1 %cmp, label %if.then, label %if.else, !sec !{!"private"}

if.then:                                          ; preds = %entry, !sec !{!"private"}
  %1 = load ptr, ptr %new_node.addr, align 8, !sec !{!"private", !"private"}
  store ptr %1, ptr @queue, align 8, !sec !{!"private", !"private"}
  %2 = load ptr, ptr @queue, align 8, !sec !{!"private", !"private"}
  %next = getelementptr inbounds %struct.node, ptr %2, i32 0, i32 6, !sec !{!"private", !"private", !"public", !"public"}
  store ptr null, ptr %next, align 8, !sec !{!"public", !"private"}
  br label %if.end, !sec !{!"public"}

if.else:                                          ; preds = %entry, !sec !{!"private"}
  %3 = load ptr, ptr @queue, align 8, !sec !{!"private", !"private"}
  store ptr %3, ptr %c, align 8, !sec !{!"private", !"private"}
  br label %while.cond, !sec !{!"public"}

while.cond:                                       ; preds = %while.body, %if.else, !sec !{!"private"}
  %4 = load ptr, ptr %c, align 8, !sec !{!"private", !"private"}
  %next1 = getelementptr inbounds %struct.node, ptr %4, i32 0, i32 6, !sec !{!"private", !"private", !"public", !"public"}
  %5 = load ptr, ptr %next1, align 8, !sec !{!"private", !"private"}
  %cmp2 = icmp ne ptr %5, null, !sec !{!"private"}
  br i1 %cmp2, label %while.body, label %while.end, !sec !{!"private"}

while.body:                                       ; preds = %while.cond, !sec !{!"private"}
  %6 = load ptr, ptr %c, align 8, !sec !{!"private", !"private"}
  %next3 = getelementptr inbounds %struct.node, ptr %6, i32 0, i32 6, !sec !{!"private", !"private", !"public", !"public"}
  %7 = load ptr, ptr %next3, align 8, !sec !{!"private", !"private"}
  store ptr %7, ptr %c, align 8, !sec !{!"private", !"private"}
  br label %while.cond, !llvm.loop !6, !sec !{!"public"}

while.end:                                        ; preds = %while.cond, !sec !{!"private"}
  %8 = load ptr, ptr %new_node.addr, align 8, !sec !{!"private", !"private"}
  %9 = load ptr, ptr %c, align 8, !sec !{!"private", !"private"}
  %next4 = getelementptr inbounds %struct.node, ptr %9, i32 0, i32 6, !sec !{!"private", !"private", !"public", !"public"}
  store ptr %8, ptr %next4, align 8, !sec !{!"private", !"private"}
  %10 = load ptr, ptr %new_node.addr, align 8, !sec !{!"private", !"private"}
  %next5 = getelementptr inbounds %struct.node, ptr %10, i32 0, i32 6, !sec !{!"private", !"private", !"public", !"public"}
  store ptr null, ptr %next5, align 8, !sec !{!"public", !"private"}
  br label %if.end, !sec !{!"public"}

if.end:                                           ; preds = %while.end, %if.then, !sec !{!"private"}
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @dequeue() #0 !sec !{!"private", !"private", !{}} {
entry:                                            ; !sec !{!"private"}
  %n = alloca ptr, align 8, !sec !{!"private"}
  %0 = load ptr, ptr @queue, align 8, !sec !{!"private", !"private"}
  store ptr %0, ptr %n, align 8, !sec !{!"private", !"private"}
  %1 = load ptr, ptr @queue, align 8, !sec !{!"private", !"private"}
  %next = getelementptr inbounds %struct.node, ptr %1, i32 0, i32 6, !sec !{!"private", !"private", !"public", !"public"}
  %2 = load ptr, ptr %next, align 8, !sec !{!"private", !"private"}
  store ptr %2, ptr @queue, align 8, !sec !{!"private", !"private"}
  %3 = load ptr, ptr %n, align 8, !sec !{!"private", !"private"}
  %next1 = getelementptr inbounds %struct.node, ptr %3, i32 0, i32 6, !sec !{!"private", !"private", !"public", !"public"}
  store ptr null, ptr %next1, align 8, !sec !{!"public", !"private"}
  %4 = load ptr, ptr %n, align 8, !sec !{!"private", !"private"}
  ret ptr %4, !sec !{!"private"}
}

;? print_leaves
;? Purpose: Debug function to print all leaf node keys in the B-tree
;? 
;? Return value analysis:
;?   - Type: void
;?   - No return value
;?   - Security label: void
;?
;? Parameter 1 (%root):
;?   - Type: ptr (pointer to struct.node)
;?   - Semantic meaning: Root of the B-tree to print
;?   - Usage in function: Traverses tree structure to find and print leaf nodes
;?   - Data it holds: Private tree structure (contains sensitive data)
;?   - Security label: private
;?   - Rationale: Tree nodes contain private data, even though we're printing them.
;?     The null check result is declassified to allow branching to printf.
;?
;? Min-PC: public (NOTE: Differs from typical pattern)
;? Rationale: Function returns void, so no return label. Min-PC is public because
;?   this is a debugging/printing function that needs to call printf (requires public PC).
;?   All branches on private data are explicitly declassified before calling printf.
; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @print_leaves(ptr noundef %root) #0 !sec !{!"void", !"public", !{!"private"}} {
entry:                                            ; !sec !{!"public"}
  %root.addr = alloca ptr, align 8, !sec !{!"private"}
  %i = alloca i64, align 8, !sec !{!"public"}
  %c = alloca ptr, align 8, !sec !{!"private"}
  store ptr %root, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %0 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %cmp = icmp eq ptr %0, null, !sec !{!"private"}
  %cmp.public = call i1 @declassify.i1(i1 noundef %cmp), !sec !{!"declassify", !"private", !"public"}
  br i1 %cmp.public, label %if.then, label %if.end, !sec !{!"public"}

if.then:                                          ; preds = %entry, !sec !{!"public"}
  %call = call i32 (ptr, ...) @printf(ptr noundef @.str.10), !sec !{!"call", !"public", !{!"public"}}
  br label %return, !sec !{!"public"}

if.end:                                           ; preds = %entry, !sec !{!"public"}
  %1 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  store ptr %1, ptr %c, align 8, !sec !{!"private", !"private"}
  br label %while.cond, !sec !{!"public"}

while.cond:                                       ; preds = %while.body, %if.end, !sec !{!"public"}
  %2 = load ptr, ptr %c, align 8, !sec !{!"private", !"private"}
  %is_leaf = getelementptr inbounds %struct.node, ptr %2, i32 0, i32 3, !sec !{!"private", !"private", !"public", !"public"}
  %3 = load i8, ptr %is_leaf, align 8, !sec !{!"private", !"private"}
  %tobool = trunc i8 %3 to i1, !sec !{!"private"}
  %lnot = xor i1 %tobool, true, !sec !{!"private"}
  %lnot.public = call i1 @declassify.i1(i1 noundef %lnot), !sec !{!"declassify", !"private", !"public"}
  br i1 %lnot.public, label %while.body, label %while.end, !sec !{!"public"}

while.body:                                       ; preds = %while.cond, !sec !{!"public"}
  %4 = load ptr, ptr %c, align 8, !sec !{!"private", !"private"}
  %pointers = getelementptr inbounds %struct.node, ptr %4, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %5 = load ptr, ptr %pointers, align 8, !sec !{!"private", !"private"}
  %arrayidx = getelementptr inbounds ptr, ptr %5, i64 0, !sec !{!"private", !"private", !"public"}
  %6 = load ptr, ptr %arrayidx, align 8, !sec !{!"private", !"private"}
  store ptr %6, ptr %c, align 8, !sec !{!"private", !"private"}
  br label %while.cond, !llvm.loop !8, !sec !{!"public"}

while.end:                                        ; preds = %while.cond, !sec !{!"public"}
  br label %while.body2, !sec !{!"public"}

while.body2:                                      ; preds = %while.end, %if.end14, !sec !{!"public"}
  store i64 0, ptr %i, align 8, !sec !{!"public", !"public"}
  br label %for.cond, !sec !{!"public"}

for.cond:                                         ; preds = %for.inc, %while.body2, !sec !{!"public"}
  %7 = load i64, ptr %i, align 8, !sec !{!"private", !"public"}
  %8 = load ptr, ptr %c, align 8, !sec !{!"private", !"private"}
  %num_keys = getelementptr inbounds %struct.node, ptr %8, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %9 = load i64, ptr %num_keys, align 8, !sec !{!"private", !"private"}
  %cmp3 = icmp ult i64 %7, %9, !sec !{!"private"}
  %cmp3.public = call i1 @declassify.i1(i1 noundef %cmp3), !sec !{!"declassify", !"private", !"public"}
  br i1 %cmp3.public, label %for.body, label %for.end, !sec !{!"public"}

for.body:                                         ; preds = %for.cond, !sec !{!"public"}
  %10 = load ptr, ptr %c, align 8, !sec !{!"private", !"private"}
  %keys = getelementptr inbounds %struct.node, ptr %10, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %11 = load ptr, ptr %keys, align 8, !sec !{!"private", !"private"}
  %12 = load i64, ptr %i, align 8, !sec !{!"public", !"public"}
  %arrayidx4 = getelementptr inbounds i64, ptr %11, i64 %12, !sec !{!"private", !"private", !"public"}
  %13 = load i64, ptr %arrayidx4, align 8, !sec !{!"private", !"private"}
  %public.13 = call i64 @declassify.i64(i64 noundef %13), !sec !{!"declassify", !"private", !"public"}
  %call5 = call i32 (ptr, ...) @printf(ptr noundef @.str.11, i64 noundef %public.13), !sec !{!"call", !"public", !{!"public", !"public"}}
  br label %for.inc, !sec !{!"public"}

for.inc:                                          ; preds = %for.body, !sec !{!"public"}
  %14 = load i64, ptr %i, align 8, !sec !{!"public", !"public"}
  %inc = add i64 %14, 1, !sec !{!"public"}
  store i64 %inc, ptr %i, align 8, !sec !{!"public", !"public"}
  br label %for.cond, !llvm.loop !9, !sec !{!"public"}

for.end:                                          ; preds = %for.cond, !sec !{!"public"}
  %15 = load ptr, ptr %c, align 8, !sec !{!"private", !"private"}
  %pointers6 = getelementptr inbounds %struct.node, ptr %15, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %16 = load ptr, ptr %pointers6, align 8, !sec !{!"private", !"private"}
  %17 = load i64, ptr @order, align 8, !sec !{!"private", !"private"}
  %sub = sub i64 %17, 1, !sec !{!"private"}
  %arrayidx7 = getelementptr inbounds ptr, ptr %16, i64 %sub, !sec !{!"private", !"private", !"private"}
  %18 = load ptr, ptr %arrayidx7, align 8, !sec !{!"private", !"private"}
  %cmp8 = icmp ne ptr %18, null, !sec !{!"private"}
  %cmp8.public = call i1 @declassify.i1(i1 noundef %cmp8), !sec !{!"declassify", !"private", !"public"}
  br i1 %cmp8.public, label %if.then9, label %if.else, !sec !{!"public"}

if.then9:                                         ; preds = %for.end, !sec !{!"public"}
  %call10 = call i32 (ptr, ...) @printf(ptr noundef @.str.12), !sec !{!"call", !"public", !{!"public"}}
  %19 = load ptr, ptr %c, align 8, !sec !{!"private", !"private"}
  %pointers11 = getelementptr inbounds %struct.node, ptr %19, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %20 = load ptr, ptr %pointers11, align 8, !sec !{!"private", !"private"}
  %21 = load i64, ptr @order, align 8, !sec !{!"private", !"private"}
  %sub12 = sub i64 %21, 1, !sec !{!"private"}
  %arrayidx13 = getelementptr inbounds ptr, ptr %20, i64 %sub12, !sec !{!"private", !"private", !"private"}
  %22 = load ptr, ptr %arrayidx13, align 8, !sec !{!"private", !"private"}
  store ptr %22, ptr %c, align 8, !sec !{!"private", !"private"}
  br label %if.end14, !sec !{!"public"}

if.else:                                          ; preds = %for.end, !sec !{!"public"}
  br label %while.end15, !sec !{!"public"}

if.end14:                                         ; preds = %if.then9, !sec !{!"public"}
  br label %while.body2, !sec !{!"public"}

while.end15:                                      ; preds = %if.else, !sec !{!"public"}
  %call16 = call i32 (ptr, ...) @printf(ptr noundef @.str.13), !sec !{!"call", !"public", !{!"public"}}
  br label %return, !sec !{!"public"}

return:                                           ; preds = %while.end15, %if.then, !sec !{!"public"}
  ret void
}

;? height
;? Purpose: Compute the height of the B-tree
;? 
;? Return value analysis:
;?   - Type: i64
;?   - Semantic meaning: Height of the tree (number of levels)
;?   - Data it holds: Derived from private tree structure
;?   - Security label: private
;?   - Rationale: Height reveals information about tree structure and number of nodes
;?
;? Parameter 1 (%root):
;?   - Type: ptr (pointer to struct.node)
;?   - Semantic meaning: Root of the B-tree
;?   - Usage in function: Traverses tree to count levels
;?   - Data it holds: Private tree structure
;?   - Security label: private
;?   - Rationale: Tree nodes are private by default
;?
;? Min-PC: private
;? Rationale: Matches return type (both private). Function traverses private tree
;?   structure and returns information derived from it.
; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @height(ptr noundef %root) #0 !sec !{!"private", !"private", !{!"private"}} {
entry:                                            ; !sec !{!"private"}
  %root.addr = alloca ptr, align 8, !sec !{!"private"}
  %h = alloca i64, align 8, !sec !{!"private"}
  %c = alloca ptr, align 8, !sec !{!"private"}
  store ptr %root, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  store i64 0, ptr %h, align 8, !sec !{!"public", !"private"}
  %0 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  store ptr %0, ptr %c, align 8, !sec !{!"private", !"private"}
  br label %while.cond, !sec !{!"public"}

while.cond:                                       ; preds = %while.body, %entry, !sec !{!"private"}
  %1 = load ptr, ptr %c, align 8, !sec !{!"private", !"private"}
  %is_leaf = getelementptr inbounds %struct.node, ptr %1, i32 0, i32 3, !sec !{!"private", !"private", !"public", !"public"}
  %2 = load i8, ptr %is_leaf, align 8, !sec !{!"private", !"private"}
  %tobool = trunc i8 %2 to i1, !sec !{!"private"}
  %lnot = xor i1 %tobool, true, !sec !{!"private"}
  br i1 %lnot, label %while.body, label %while.end, !sec !{!"private"}

while.body:                                       ; preds = %while.cond, !sec !{!"private"}
  %3 = load ptr, ptr %c, align 8, !sec !{!"private", !"private"}
  %pointers = getelementptr inbounds %struct.node, ptr %3, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %4 = load ptr, ptr %pointers, align 8, !sec !{!"private", !"private"}
  %arrayidx = getelementptr inbounds ptr, ptr %4, i64 0, !sec !{!"private", !"private", !"public"}
  %5 = load ptr, ptr %arrayidx, align 8, !sec !{!"private", !"private"}
  store ptr %5, ptr %c, align 8, !sec !{!"private", !"private"}
  %6 = load i64, ptr %h, align 8, !sec !{!"private", !"private"}
  %inc = add i64 %6, 1, !sec !{!"private"}
  store i64 %inc, ptr %h, align 8, !sec !{!"private", !"private"}
  br label %while.cond, !llvm.loop !10, !sec !{!"public"}

while.end:                                        ; preds = %while.cond, !sec !{!"private"}
  %7 = load i64, ptr %h, align 8, !sec !{!"private", !"private"}
  ret i64 %7, !sec !{!"private"}
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @path_to_root(ptr noundef %root, ptr noundef %child) #0 !sec !{!"private", !"private", !{!"private", !"private"}} {
entry:                                            ; !sec !{!"private"}
  %root.addr = alloca ptr, align 8, !sec !{!"private"}
  %child.addr = alloca ptr, align 8, !sec !{!"private"}
  %length = alloca i64, align 8, !sec !{!"private"}
  %c = alloca ptr, align 8, !sec !{!"private"}
  store ptr %root, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  store ptr %child, ptr %child.addr, align 8, !sec !{!"private", !"private"}
  store i64 0, ptr %length, align 8, !sec !{!"public", !"private"}
  %0 = load ptr, ptr %child.addr, align 8, !sec !{!"private", !"private"}
  store ptr %0, ptr %c, align 8, !sec !{!"private", !"private"}
  br label %while.cond, !sec !{!"public"}

while.cond:                                       ; preds = %while.body, %entry, !sec !{!"private"}
  %1 = load ptr, ptr %c, align 8, !sec !{!"private", !"private"}
  %2 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %cmp = icmp ne ptr %1, %2, !sec !{!"private"}
  br i1 %cmp, label %while.body, label %while.end, !sec !{!"private"}

while.body:                                       ; preds = %while.cond, !sec !{!"private"}
  %3 = load ptr, ptr %c, align 8, !sec !{!"private", !"private"}
  %parent = getelementptr inbounds %struct.node, ptr %3, i32 0, i32 2, !sec !{!"private", !"private", !"public", !"public"}
  %4 = load ptr, ptr %parent, align 8, !sec !{!"private", !"private"}
  store ptr %4, ptr %c, align 8, !sec !{!"private", !"private"}
  %5 = load i64, ptr %length, align 8, !sec !{!"private", !"private"}
  %inc = add i64 %5, 1, !sec !{!"private"}
  store i64 %inc, ptr %length, align 8, !sec !{!"private", !"private"}
  br label %while.cond, !llvm.loop !11, !sec !{!"public"}

while.end:                                        ; preds = %while.cond, !sec !{!"private"}
  %6 = load i64, ptr %length, align 8, !sec !{!"private", !"private"}
  ret i64 %6, !sec !{!"private"}
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @print_tree(ptr noundef %root) #0 !sec !{!"void", !"public", !{!"private"}} {
entry:                                            ; !sec !{!"public"}
  %root.addr = alloca ptr, align 8, !sec !{!"private"}
  %n = alloca ptr, align 8, !sec !{!"private"}
  %i = alloca i64, align 8, !sec !{!"public"}
  %rank = alloca i64, align 8, !sec !{!"private"}
  %new_rank = alloca i64, align 8, !sec !{!"private"}
  store ptr %root, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  store ptr null, ptr %n, align 8, !sec !{!"public", !"private"}
  store i64 0, ptr %i, align 8, !sec !{!"public", !"public"}
  store i64 0, ptr %rank, align 8, !sec !{!"public", !"private"}
  store i64 0, ptr %new_rank, align 8, !sec !{!"public", !"private"}
  %0 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %cmp = icmp eq ptr %0, null, !sec !{!"private"}
  %cmp.public = call i1 @declassify.i1(i1 noundef %cmp), !sec !{!"declassify", !"private", !"public"}
  br i1 %cmp.public, label %if.then, label %if.end, !sec !{!"public"}

if.then:                                          ; preds = %entry, !sec !{!"public"}
  %call = call i32 (ptr, ...) @printf(ptr noundef @.str.10), !sec !{!"call", !"public", !{!"public"}}
  br label %return, !sec !{!"public"}

if.end:                                           ; preds = %entry, !sec !{!"public"}
  store ptr null, ptr @queue, align 8, !sec !{!"private", !"private"}
  %1 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  call void @enqueue(ptr noundef %1), !sec !{!"call", !"void", !{!"private"}}
  br label %while.cond, !sec !{!"public"}

while.cond:                                       ; preds = %if.end26, %if.end, !sec !{!"public"}
  %2 = load ptr, ptr @queue, align 8, !sec !{!"private", !"private"}
  %cmp1 = icmp ne ptr %2, null, !sec !{!"private"}
  %cmp1.public = call i1 @declassify.i1(i1 noundef %cmp1), !sec !{!"declassify", !"private", !"public"}
  br i1 %cmp1.public, label %while.body, label %while.end, !sec !{!"public"}

while.body:                                       ; preds = %while.cond, !sec !{!"public"}
  %call2 = call ptr @dequeue(), !sec !{!"call", !"private", !{}}
  store ptr %call2, ptr %n, align 8, !sec !{!"private", !"private"}
  %3 = load ptr, ptr %n, align 8, !sec !{!"private", !"private"}
  %parent = getelementptr inbounds %struct.node, ptr %3, i32 0, i32 2, !sec !{!"private", !"private", !"public", !"public"}
  %4 = load ptr, ptr %parent, align 8, !sec !{!"private", !"private"}
  %cmp3 = icmp ne ptr %4, null, !sec !{!"private"}
  %cmp3.public = call i1 @declassify.i1(i1 noundef %cmp3), !sec !{!"declassify", !"private", !"public"}
  br i1 %cmp3.public, label %land.lhs.true, label %if.end12, !sec !{!"public"}

land.lhs.true:                                    ; preds = %while.body, !sec !{!"public"}
  %5 = load ptr, ptr %n, align 8, !sec !{!"private", !"private"}
  %6 = load ptr, ptr %n, align 8, !sec !{!"private", !"private"}
  %parent4 = getelementptr inbounds %struct.node, ptr %6, i32 0, i32 2, !sec !{!"private", !"private", !"public", !"public"}
  %7 = load ptr, ptr %parent4, align 8, !sec !{!"private", !"private"}
  %pointers = getelementptr inbounds %struct.node, ptr %7, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %8 = load ptr, ptr %pointers, align 8, !sec !{!"private", !"private"}
  %arrayidx = getelementptr inbounds ptr, ptr %8, i64 0, !sec !{!"private", !"private", !"public"}
  %9 = load ptr, ptr %arrayidx, align 8, !sec !{!"private", !"private"}
  %cmp5 = icmp eq ptr %5, %9, !sec !{!"private"}
  %cmp5.public = call i1 @declassify.i1(i1 noundef %cmp5), !sec !{!"declassify", !"private", !"public"}
  br i1 %cmp5.public, label %if.then6, label %if.end12, !sec !{!"public"}

if.then6:                                         ; preds = %land.lhs.true, !sec !{!"public"}
  %10 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %11 = load ptr, ptr %n, align 8, !sec !{!"private", !"private"}
  %call7 = call i64 @path_to_root(ptr noundef %10, ptr noundef %11), !sec !{!"call", !"private", !{!"private", !"private"}}
  store i64 %call7, ptr %new_rank, align 8, !sec !{!"private", !"private"}
  %12 = load i64, ptr %new_rank, align 8, !sec !{!"private", !"private"}
  %13 = load i64, ptr %rank, align 8, !sec !{!"private", !"private"}
  %cmp8 = icmp ne i64 %12, %13, !sec !{!"private"}
  %cmp8.public = call i1 @declassify.i1(i1 noundef %cmp8), !sec !{!"declassify", !"private", !"public"}
  br i1 %cmp8.public, label %if.then9, label %if.end11, !sec !{!"public"}

if.then9:                                         ; preds = %if.then6, !sec !{!"public"}
  %14 = load i64, ptr %new_rank, align 8, !sec !{!"private", !"private"}
  store i64 %14, ptr %rank, align 8, !sec !{!"private", !"private"}
  %call10 = call i32 (ptr, ...) @printf(ptr noundef @.str.13), !sec !{!"call", !"public", !{!"public"}}
  br label %if.end11, !sec !{!"public"}

if.end11:                                         ; preds = %if.then9, %if.then6, !sec !{!"public"}
  br label %if.end12, !sec !{!"public"}

if.end12:                                         ; preds = %if.end11, %land.lhs.true, %while.body, !sec !{!"public"}
  store i64 0, ptr %i, align 8, !sec !{!"public", !"public"}
  br label %for.cond, !sec !{!"public"}

for.cond:                                         ; preds = %for.inc, %if.end12, !sec !{!"public"}
  %15 = load i64, ptr %i, align 8, !sec !{!"private", !"public"}
  %16 = load ptr, ptr %n, align 8, !sec !{!"private", !"private"}
  %num_keys = getelementptr inbounds %struct.node, ptr %16, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %17 = load i64, ptr %num_keys, align 8, !sec !{!"private", !"private"}
  %cmp13 = icmp ult i64 %15, %17, !sec !{!"private"}
  %cmp13.public = call i1 @declassify.i1(i1 noundef %cmp13), !sec !{!"declassify", !"private", !"public"}
  br i1 %cmp13.public, label %for.body, label %for.end, !sec !{!"public"}

for.body:                                         ; preds = %for.cond, !sec !{!"public"}
  %18 = load ptr, ptr %n, align 8, !sec !{!"private", !"private"}
  %keys = getelementptr inbounds %struct.node, ptr %18, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %19 = load ptr, ptr %keys, align 8, !sec !{!"private", !"private"}
  %20 = load i64, ptr %i, align 8, !sec !{!"public", !"public"}
  %arrayidx14 = getelementptr inbounds i64, ptr %19, i64 %20, !sec !{!"private", !"private", !"public"}
  %21 = load i64, ptr %arrayidx14, align 8, !sec !{!"private", !"private"}
  %public.21 = call i64 @declassify.i64(i64 noundef %21), !sec !{!"declassify", !"private", !"public"}
  %call15 = call i32 (ptr, ...) @printf(ptr noundef @.str.11, i64 noundef %public.21), !sec !{!"call", !"public", !{!"public", !"public"}}
  br label %for.inc, !sec !{!"public"}

for.inc:                                          ; preds = %for.body, !sec !{!"public"}
  %22 = load i64, ptr %i, align 8, !sec !{!"public", !"public"}
  %inc = add i64 %22, 1, !sec !{!"public"}
  store i64 %inc, ptr %i, align 8, !sec !{!"public", !"public"}
  br label %for.cond, !llvm.loop !12, !sec !{!"public"}

for.end:                                          ; preds = %for.cond, !sec !{!"public"}
  %23 = load ptr, ptr %n, align 8, !sec !{!"private", !"private"}
  %is_leaf = getelementptr inbounds %struct.node, ptr %23, i32 0, i32 3, !sec !{!"private", !"private", !"public", !"public"}
  %24 = load i8, ptr %is_leaf, align 8, !sec !{!"private", !"private"}
  %tobool = trunc i8 %24 to i1, !sec !{!"private"}
  %tobool.public = call i1 @declassify.i1(i1 noundef %tobool), !sec !{!"declassify", !"private", !"public"}
  br i1 %tobool.public, label %if.end26, label %if.then16, !sec !{!"public"}

if.then16:                                        ; preds = %for.end, !sec !{!"public"}
  store i64 0, ptr %i, align 8, !sec !{!"public", !"public"}
  br label %for.cond17, !sec !{!"public"}

for.cond17:                                       ; preds = %for.inc23, %if.then16, !sec !{!"public"}
  %25 = load i64, ptr %i, align 8, !sec !{!"private", !"public"}
  %26 = load ptr, ptr %n, align 8, !sec !{!"private", !"private"}
  %num_keys18 = getelementptr inbounds %struct.node, ptr %26, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %27 = load i64, ptr %num_keys18, align 8, !sec !{!"private", !"private"}
  %cmp19 = icmp ule i64 %25, %27, !sec !{!"private"}
  %cmp19.public = call i1 @declassify.i1(i1 noundef %cmp19), !sec !{!"declassify", !"private", !"public"}
  br i1 %cmp19.public, label %for.body20, label %for.end25, !sec !{!"public"}

for.body20:                                       ; preds = %for.cond17, !sec !{!"public"}
  %28 = load ptr, ptr %n, align 8, !sec !{!"private", !"private"}
  %pointers21 = getelementptr inbounds %struct.node, ptr %28, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %29 = load ptr, ptr %pointers21, align 8, !sec !{!"private", !"private"}
  %30 = load i64, ptr %i, align 8, !sec !{!"public", !"public"}
  %arrayidx22 = getelementptr inbounds ptr, ptr %29, i64 %30, !sec !{!"private", !"private", !"public"}
  %31 = load ptr, ptr %arrayidx22, align 8, !sec !{!"private", !"private"}
  call void @enqueue(ptr noundef %31), !sec !{!"call", !"void", !{!"private"}}
  br label %for.inc23, !sec !{!"public"}

for.inc23:                                        ; preds = %for.body20, !sec !{!"public"}
  %32 = load i64, ptr %i, align 8, !sec !{!"public", !"public"}
  %inc24 = add i64 %32, 1, !sec !{!"public"}
  store i64 %inc24, ptr %i, align 8, !sec !{!"public", !"public"}
  br label %for.cond17, !llvm.loop !13, !sec !{!"public"}

for.end25:                                        ; preds = %for.cond17, !sec !{!"public"}
  br label %if.end26, !sec !{!"public"}

if.end26:                                         ; preds = %for.end25, %for.end, !sec !{!"public"}
  %call27 = call i32 (ptr, ...) @printf(ptr noundef @.str.14), !sec !{!"call", !"public", !{!"public"}}
  br label %while.cond, !llvm.loop !14, !sec !{!"public"}

while.end:                                        ; preds = %while.cond, !sec !{!"public"}
  %call28 = call i32 (ptr, ...) @printf(ptr noundef @.str.13), !sec !{!"call", !"public", !{!"public"}}
  br label %return, !sec !{!"public"}

return:                                           ; preds = %while.end, %if.then, !sec !{!"public"}
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @find_and_print(ptr noundef %root, i64 noundef %key) #0 !sec !{!"void", !"public", !{!"private", !"private"}} {
entry:                                            ; !sec !{!"public"}
  %root.addr = alloca ptr, align 8, !sec !{!"private"}
  %key.addr = alloca i64, align 8, !sec !{!"private"}
  %r = alloca ptr, align 8, !sec !{!"private"}
  store ptr %root, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  store i64 %key, ptr %key.addr, align 8, !sec !{!"private", !"private"}
  %0 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %1 = load i64, ptr %key.addr, align 8, !sec !{!"private", !"private"}
  %call = call ptr @find(ptr noundef %0, i64 noundef %1, ptr noundef null), !sec !{!"call", !"private", !{!"private", !"private", !"private"}}
  store ptr %call, ptr %r, align 8, !sec !{!"private", !"private"}
  %2 = load ptr, ptr %r, align 8, !sec !{!"private", !"private"}
  %cmp = icmp eq ptr %2, null, !sec !{!"private"}
  %cmp.public = call i1 @declassify.i1(i1 noundef %cmp), !sec !{!"declassify", !"private", !"public"}
  br i1 %cmp.public, label %if.then, label %if.else, !sec !{!"public"}

if.then:                                          ; preds = %entry, !sec !{!"public"}
  %3 = load i64, ptr %key.addr, align 8, !sec !{!"private", !"private"}
  %public.3 = call i64 @declassify.i64(i64 noundef %3), !sec !{!"declassify", !"private", !"public"}
  %call1 = call i32 (ptr, ...) @printf(ptr noundef @.str.15, i64 noundef %public.3), !sec !{!"call", !"public", !{!"public", !"public"}}
  br label %if.end, !sec !{!"public"}

if.else:                                          ; preds = %entry, !sec !{!"public"}
  %4 = load ptr, ptr %r, align 8, !sec !{!"private", !"private"}
  %public.4 = call ptr @declassify.ptr(ptr noundef %4), !sec !{!"declassify", !"private", !"public"}
  %5 = load i64, ptr %key.addr, align 8, !sec !{!"private", !"private"}
  %public.5 = call i64 @declassify.i64(i64 noundef %5), !sec !{!"declassify", !"private", !"public"}
  %6 = load ptr, ptr %r, align 8, !sec !{!"private", !"private"}
  %value = getelementptr inbounds %struct.record, ptr %6, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %7 = load i64, ptr %value, align 8, !sec !{!"private", !"private"}
  %public.7 = call i64 @declassify.i64(i64 noundef %7), !sec !{!"declassify", !"private", !"public"}
  %call2 = call i32 (ptr, ...) @printf(ptr noundef @.str.16, ptr noundef %public.4, i64 noundef %public.5, i64 noundef %public.7), !sec !{!"call", !"public", !{!"public", !"public", !"public", !"public"}}
  br label %if.end, !sec !{!"public"}

if.end:                                           ; preds = %if.else, %if.then, !sec !{!"public"}
  ret void
}

;? find
;? Purpose: Search for a key in the B-tree and return pointer to its record
;?
;? Return value analysis:
;?   - Type: ptr (pointer to record data)
;?   - Semantic meaning: Address of the record associated with the search key
;?   - Data it holds: Points to private data stored in tree nodes
;?   - Security label: private
;?   - Rationale: Returns pointers into the private tree structure, exposing node contents
;?
;? Parameter 1 (root):
;?   - Type: ptr (pointer to struct.node)
;?   - Semantic meaning: Root node of the B-tree
;?   - Usage in function: Starting point for tree traversal via find_leaf
;?   - Data it holds/points to: Private tree node containing keys, pointers, metadata
;?   - Security label: private
;?   - Rationale: All tree nodes are private by default (design principle)
;?
;? Parameter 2 (key):
;?   - Type: i64 (64-bit integer)
;?   - Semantic meaning: The key value to search for
;?   - Usage in function: Passed to find_leaf, used to locate correct leaf
;?   - Data it holds: Search key (may be derived from private data in calling context)
;?   - Security label: private
;?   - Rationale: Keys used to navigate private tree structure, assumed private
;?
;? Parameter 3 (leaf_out):
;?   - Type: ptr (pointer to pointer to struct.node)
;?   - Semantic meaning: Output parameter to store the leaf node where key was found/would be
;?   - Usage in function: Receives result from find_leaf call
;?   - Data it holds/points to: Will point to private leaf node
;?   - Security label: private
;?   - Rationale: Stores pointer to private tree node
;?
;? Min-PC: private
;? Rationale: Matches return type (private). Function performs private operations on tree
;?            structure throughout execution. No public operations or I/O.
; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @find(ptr noundef %root, i64 noundef %key, ptr noundef %leaf_out) #0 !sec !{!"private", !"private", !{!"private", !"private", !"private"}} {
entry:                                            ; !sec !{!"private"}
  %retval = alloca ptr, align 8, !sec !{!"private"}
  %root.addr = alloca ptr, align 8, !sec !{!"private"}
  %key.addr = alloca i64, align 8, !sec !{!"private"}
  %leaf_out.addr = alloca ptr, align 8, !sec !{!"private"}
  %i = alloca i64, align 8, !sec !{!"private"}
  %leaf = alloca ptr, align 8, !sec !{!"private"}
  store ptr %root, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  store i64 %key, ptr %key.addr, align 8, !sec !{!"private", !"private"}
  store ptr %leaf_out, ptr %leaf_out.addr, align 8, !sec !{!"private", !"private"}
  %0 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %cmp = icmp eq ptr %0, null, !sec !{!"private"}
  br i1 %cmp, label %if.then, label %if.end3, !sec !{!"private"}

if.then:                                          ; preds = %entry, !sec !{!"private"}
  %1 = load ptr, ptr %leaf_out.addr, align 8, !sec !{!"private", !"private"}
  %cmp1 = icmp ne ptr %1, null, !sec !{!"private"}
  br i1 %cmp1, label %if.then2, label %if.end, !sec !{!"private"}

if.then2:                                         ; preds = %if.then, !sec !{!"private"}
  %2 = load ptr, ptr %leaf_out.addr, align 8, !sec !{!"private", !"private"}
  store ptr null, ptr %2, align 8, !sec !{!"public", !"private"}
  br label %if.end, !sec !{!"public"}

if.end:                                           ; preds = %if.then2, %if.then, !sec !{!"private"}
  store ptr null, ptr %retval, align 8, !sec !{!"public", !"private"}
  br label %return, !sec !{!"public"}

if.end3:                                          ; preds = %entry, !sec !{!"private"}
  store i64 0, ptr %i, align 8, !sec !{!"public", !"private"}
  store ptr null, ptr %leaf, align 8, !sec !{!"public", !"private"}
  %3 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %4 = load i64, ptr %key.addr, align 8, !sec !{!"private", !"private"}
  %call = call ptr @find_leaf(ptr noundef %3, i64 noundef %4), !sec !{!"call", !"private", !{!"private", !"private"}}
  store ptr %call, ptr %leaf, align 8, !sec !{!"private", !"private"}
  store i64 0, ptr %i, align 8, !sec !{!"public", !"private"}
  br label %for.cond, !sec !{!"public"}

for.cond:                                         ; preds = %for.inc, %if.end3, !sec !{!"private"}
  %5 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %6 = load ptr, ptr %leaf, align 8, !sec !{!"private", !"private"}
  %num_keys = getelementptr inbounds %struct.node, ptr %6, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %7 = load i64, ptr %num_keys, align 8, !sec !{!"private", !"private"}
  %cmp4 = icmp ult i64 %5, %7, !sec !{!"private"}
  br i1 %cmp4, label %for.body, label %for.end, !sec !{!"private"}

for.body:                                         ; preds = %for.cond, !sec !{!"private"}
  %8 = load ptr, ptr %leaf, align 8, !sec !{!"private", !"private"}
  %keys = getelementptr inbounds %struct.node, ptr %8, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %9 = load ptr, ptr %keys, align 8, !sec !{!"private", !"private"}
  %10 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx = getelementptr inbounds i64, ptr %9, i64 %10, !sec !{!"private", !"private", !"private"}
  %11 = load i64, ptr %arrayidx, align 8, !sec !{!"private", !"private"}
  %12 = load i64, ptr %key.addr, align 8, !sec !{!"private", !"private"}
  %cmp5 = icmp eq i64 %11, %12, !sec !{!"private"}
  br i1 %cmp5, label %if.then6, label %if.end7, !sec !{!"private"}

if.then6:                                         ; preds = %for.body, !sec !{!"private"}
  br label %for.end, !sec !{!"public"}

if.end7:                                          ; preds = %for.body, !sec !{!"private"}
  br label %for.inc, !sec !{!"public"}

for.inc:                                          ; preds = %if.end7, !sec !{!"private"}
  %13 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %inc = add i64 %13, 1, !sec !{!"private"}
  store i64 %inc, ptr %i, align 8, !sec !{!"private", !"private"}
  br label %for.cond, !llvm.loop !15, !sec !{!"public"}

for.end:                                          ; preds = %if.then6, %for.cond, !sec !{!"private"}
  %14 = load ptr, ptr %leaf_out.addr, align 8, !sec !{!"private", !"private"}
  %cmp8 = icmp ne ptr %14, null, !sec !{!"private"}
  br i1 %cmp8, label %if.then9, label %if.end10, !sec !{!"private"}

if.then9:                                         ; preds = %for.end, !sec !{!"private"}
  %15 = load ptr, ptr %leaf, align 8, !sec !{!"private", !"private"}
  %16 = load ptr, ptr %leaf_out.addr, align 8, !sec !{!"private", !"private"}
  store ptr %15, ptr %16, align 8, !sec !{!"private", !"private"}
  br label %if.end10, !sec !{!"public"}

if.end10:                                         ; preds = %if.then9, %for.end, !sec !{!"private"}
  %17 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %18 = load ptr, ptr %leaf, align 8, !sec !{!"private", !"private"}
  %num_keys11 = getelementptr inbounds %struct.node, ptr %18, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %19 = load i64, ptr %num_keys11, align 8, !sec !{!"private", !"private"}
  %cmp12 = icmp eq i64 %17, %19, !sec !{!"private"}
  br i1 %cmp12, label %if.then13, label %if.else, !sec !{!"private"}

if.then13:                                        ; preds = %if.end10, !sec !{!"private"}
  store ptr null, ptr %retval, align 8, !sec !{!"public", !"private"}
  br label %return, !sec !{!"public"}

if.else:                                          ; preds = %if.end10, !sec !{!"private"}
  %20 = load ptr, ptr %leaf, align 8, !sec !{!"private", !"private"}
  %pointers = getelementptr inbounds %struct.node, ptr %20, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %21 = load ptr, ptr %pointers, align 8, !sec !{!"private", !"private"}
  %22 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx14 = getelementptr inbounds ptr, ptr %21, i64 %22, !sec !{!"private", !"private", !"private"}
  %23 = load ptr, ptr %arrayidx14, align 8, !sec !{!"private", !"private"}
  store ptr %23, ptr %retval, align 8, !sec !{!"private", !"private"}
  br label %return, !sec !{!"public"}

return:                                           ; preds = %if.else, %if.then13, %if.end, !sec !{!"private"}
  %24 = load ptr, ptr %retval, align 8, !sec !{!"private", !"private"}
  ret ptr %24, !sec !{!"private"}
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @find_and_print_range(ptr noundef %root, i64 noundef %key_start, i64 noundef %key_end) #0 !sec !{!"void", !"public", !{!"private", !"private", !"private"}} {
entry:                                            ; !sec !{!"public"}
  %root.addr = alloca ptr, align 8, !sec !{!"private"}
  %key_start.addr = alloca i64, align 8, !sec !{!"private"}
  %key_end.addr = alloca i64, align 8, !sec !{!"private"}
  %i = alloca i64, align 8, !sec !{!"public"}
  %array_size = alloca i64, align 8, !sec !{!"private"}
  %saved_stack = alloca ptr, align 8, !sec !{!"public"}
  %__vla_expr0 = alloca i64, align 8, !sec !{!"private"}
  %__vla_expr1 = alloca i64, align 8, !sec !{!"private"}
  %num_found = alloca i64, align 8, !sec !{!"private"}
  store ptr %root, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  store i64 %key_start, ptr %key_start.addr, align 8, !sec !{!"private", !"private"}
  store i64 %key_end, ptr %key_end.addr, align 8, !sec !{!"private", !"private"}
  %0 = load i64, ptr %key_end.addr, align 8, !sec !{!"private", !"private"}
  %1 = load i64, ptr %key_start.addr, align 8, !sec !{!"private", !"private"}
  %sub = sub i64 %0, %1, !sec !{!"private"}
  %add = add i64 %sub, 1, !sec !{!"private"}
  store i64 %add, ptr %array_size, align 8, !sec !{!"private", !"private"}
  %2 = load i64, ptr %array_size, align 8, !sec !{!"private", !"private"}
  %3 = call ptr @llvm.stacksave(), !sec !{!"call", !"public", !{}}
  store ptr %3, ptr %saved_stack, align 8, !sec !{!"public", !"public"}
  %vla = alloca i64, i64 %2, align 16, !sec !{!"private"}
  store i64 %2, ptr %__vla_expr0, align 8, !sec !{!"private", !"private"}
  %4 = load i64, ptr %array_size, align 8, !sec !{!"private", !"private"}
  %vla1 = alloca ptr, i64 %4, align 16, !sec !{!"private"}
  store i64 %4, ptr %__vla_expr1, align 8, !sec !{!"private", !"private"}
  %5 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %6 = load i64, ptr %key_start.addr, align 8, !sec !{!"private", !"private"}
  %7 = load i64, ptr %key_end.addr, align 8, !sec !{!"private", !"private"}
  %call = call i64 @find_range(ptr noundef %5, i64 noundef %6, i64 noundef %7, ptr noundef %vla, ptr noundef %vla1), !sec !{!"call", !"private", !{!"private", !"private", !"private", !"private", !"private"}}
  store i64 %call, ptr %num_found, align 8, !sec !{!"private", !"private"}
  %8 = load i64, ptr %num_found, align 8, !sec !{!"private", !"private"}
  %tobool = icmp ne i64 %8, 0, !sec !{!"private"}
  %tobool.public = call i1 @declassify.i1(i1 noundef %tobool), !sec !{!"declassify", !"private", !"public"}
  br i1 %tobool.public, label %if.else, label %if.then, !sec !{!"public"}

if.then:                                          ; preds = %entry, !sec !{!"public"}
  %call2 = call i32 (ptr, ...) @printf(ptr noundef @.str.17), !sec !{!"call", !"public", !{!"public"}}
  br label %if.end, !sec !{!"public"}

if.else:                                          ; preds = %entry, !sec !{!"public"}
  store i64 0, ptr %i, align 8, !sec !{!"public", !"public"}
  br label %for.cond, !sec !{!"public"}

for.cond:                                         ; preds = %for.inc, %if.else, !sec !{!"public"}
  %9 = load i64, ptr %i, align 8, !sec !{!"private", !"public"}
  %10 = load i64, ptr %num_found, align 8, !sec !{!"private", !"private"}
  %cmp = icmp ult i64 %9, %10, !sec !{!"private"}
  %cmp.public = call i1 @declassify.i1(i1 noundef %cmp), !sec !{!"declassify", !"private", !"public"}
  br i1 %cmp.public, label %for.body, label %for.end, !sec !{!"public"}

for.body:                                         ; preds = %for.cond, !sec !{!"public"}
  %11 = load i64, ptr %i, align 8, !sec !{!"public", !"public"}
  %arrayidx = getelementptr inbounds i64, ptr %vla, i64 %11, !sec !{!"private", !"private", !"public"}
  %12 = load i64, ptr %arrayidx, align 8, !sec !{!"private", !"private"}
  %public.12 = call i64 @declassify.i64(i64 noundef %12), !sec !{!"declassify", !"private", !"public"}
  %13 = load i64, ptr %i, align 8, !sec !{!"public", !"public"}
  %arrayidx3 = getelementptr inbounds ptr, ptr %vla1, i64 %13, !sec !{!"private", !"private", !"public"}
  %14 = load ptr, ptr %arrayidx3, align 8, !sec !{!"private", !"private"}
  %public.14 = call ptr @declassify.ptr(ptr noundef %14), !sec !{!"declassify", !"private", !"public"}
  %15 = load i64, ptr %i, align 8, !sec !{!"public", !"public"}
  %arrayidx4 = getelementptr inbounds ptr, ptr %vla1, i64 %15, !sec !{!"private", !"private", !"public"}
  %16 = load ptr, ptr %arrayidx4, align 8, !sec !{!"private", !"private"}
  %value = getelementptr inbounds %struct.record, ptr %16, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %17 = load i64, ptr %value, align 8, !sec !{!"private", !"private"}
  %public.17 = call i64 @declassify.i64(i64 noundef %17), !sec !{!"declassify", !"private", !"public"}
  %call5 = call i32 (ptr, ...) @printf(ptr noundef @.str.18, i64 noundef %public.12, ptr noundef %public.14, i64 noundef %public.17), !sec !{!"call", !"public", !{!"public", !"public", !"public", !"public"}}
  br label %for.inc, !sec !{!"public"}

for.inc:                                          ; preds = %for.body, !sec !{!"public"}
  %18 = load i64, ptr %i, align 8, !sec !{!"public", !"public"}
  %inc = add i64 %18, 1, !sec !{!"public"}
  store i64 %inc, ptr %i, align 8, !sec !{!"public", !"public"}
  br label %for.cond, !llvm.loop !16, !sec !{!"public"}

for.end:                                          ; preds = %for.cond, !sec !{!"public"}
  br label %if.end, !sec !{!"public"}

if.end:                                           ; preds = %for.end, %if.then, !sec !{!"public"}
  %19 = load ptr, ptr %saved_stack, align 8, !sec !{!"public", !"public"}
  call void @llvm.stackrestore(ptr %19), !sec !{!"call", !"void", !{!"public"}}
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn
; This had to be altered to remove the .p0 suffix otherwise clang complained
declare !sec !{!"public", !"public", !{}} ptr @llvm.stacksave() #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @find_range(ptr noundef %root, i64 noundef %key_start, i64 noundef %key_end, ptr noundef %returned_keys, ptr noundef %returned_pointers) #0 !sec !{!"private", !"private", !{!"private", !"private", !"private", !"private", !"private"}} {
entry:                                            ; !sec !{!"private"}
  %retval = alloca i64, align 8, !sec !{!"private"}
  %root.addr = alloca ptr, align 8, !sec !{!"private"}
  %key_start.addr = alloca i64, align 8, !sec !{!"private"}
  %key_end.addr = alloca i64, align 8, !sec !{!"private"}
  %returned_keys.addr = alloca ptr, align 8, !sec !{!"private"}
  %returned_pointers.addr = alloca ptr, align 8, !sec !{!"private"}
  %i = alloca i64, align 8, !sec !{!"private"}
  %num_found = alloca i64, align 8, !sec !{!"private"}
  %n = alloca ptr, align 8, !sec !{!"private"}
  store ptr %root, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  store i64 %key_start, ptr %key_start.addr, align 8, !sec !{!"private", !"private"}
  store i64 %key_end, ptr %key_end.addr, align 8, !sec !{!"private", !"private"}
  store ptr %returned_keys, ptr %returned_keys.addr, align 8, !sec !{!"private", !"private"}
  store ptr %returned_pointers, ptr %returned_pointers.addr, align 8, !sec !{!"private", !"private"}
  store i64 0, ptr %num_found, align 8, !sec !{!"public", !"private"}
  %0 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %1 = load i64, ptr %key_start.addr, align 8, !sec !{!"private", !"private"}
  %call = call ptr @find_leaf(ptr noundef %0, i64 noundef %1), !sec !{!"call", !"private", !{!"private", !"private"}}
  store ptr %call, ptr %n, align 8, !sec !{!"private", !"private"}
  %2 = load ptr, ptr %n, align 8, !sec !{!"private", !"private"}
  %cmp = icmp eq ptr %2, null, !sec !{!"private"}
  br i1 %cmp, label %if.then, label %if.end, !sec !{!"private"}

if.then:                                          ; preds = %entry, !sec !{!"private"}
  store i64 0, ptr %retval, align 8, !sec !{!"public", !"private"}
  br label %return, !sec !{!"public"}

if.end:                                           ; preds = %entry, !sec !{!"private"}
  store i64 0, ptr %i, align 8, !sec !{!"public", !"private"}
  br label %for.cond, !sec !{!"public"}

for.cond:                                         ; preds = %for.inc, %if.end, !sec !{!"private"}
  %3 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %4 = load ptr, ptr %n, align 8, !sec !{!"private", !"private"}
  %num_keys = getelementptr inbounds %struct.node, ptr %4, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %5 = load i64, ptr %num_keys, align 8, !sec !{!"private", !"private"}
  %cmp1 = icmp ult i64 %3, %5, !sec !{!"private"}
  br i1 %cmp1, label %land.rhs, label %land.end, !sec !{!"private"}

land.rhs:                                         ; preds = %for.cond, !sec !{!"private"}
  %6 = load ptr, ptr %n, align 8, !sec !{!"private", !"private"}
  %keys = getelementptr inbounds %struct.node, ptr %6, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %7 = load ptr, ptr %keys, align 8, !sec !{!"private", !"private"}
  %8 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx = getelementptr inbounds i64, ptr %7, i64 %8, !sec !{!"private", !"private", !"private"}
  %9 = load i64, ptr %arrayidx, align 8, !sec !{!"private", !"private"}
  %10 = load i64, ptr %key_start.addr, align 8, !sec !{!"private", !"private"}
  %cmp2 = icmp ult i64 %9, %10, !sec !{!"private"}
  br label %land.end, !sec !{!"public"}

land.end:                                         ; preds = %land.rhs, %for.cond, !sec !{!"private"}
  %11 = phi i1 [ false, %for.cond ], [ %cmp2, %land.rhs ], !sec !{!"private"}
  br i1 %11, label %for.body, label %for.end, !sec !{!"private"}

for.body:                                         ; preds = %land.end, !sec !{!"private"}
  br label %for.inc, !sec !{!"public"}

for.inc:                                          ; preds = %for.body, !sec !{!"private"}
  %12 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %inc = add i64 %12, 1, !sec !{!"private"}
  store i64 %inc, ptr %i, align 8, !sec !{!"private", !"private"}
  br label %for.cond, !llvm.loop !17, !sec !{!"public"}

for.end:                                          ; preds = %land.end, !sec !{!"private"}
  %13 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %14 = load ptr, ptr %n, align 8, !sec !{!"private", !"private"}
  %num_keys3 = getelementptr inbounds %struct.node, ptr %14, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %15 = load i64, ptr %num_keys3, align 8, !sec !{!"private", !"private"}
  %cmp4 = icmp eq i64 %13, %15, !sec !{!"private"}
  br i1 %cmp4, label %if.then5, label %if.end6, !sec !{!"private"}

if.then5:                                         ; preds = %for.end, !sec !{!"private"}
  store i64 0, ptr %retval, align 8, !sec !{!"public", !"private"}
  br label %return, !sec !{!"public"}

if.end6:                                          ; preds = %for.end, !sec !{!"private"}
  br label %while.cond, !sec !{!"public"}

while.cond:                                       ; preds = %for.end25, %if.end6, !sec !{!"private"}
  %16 = load ptr, ptr %n, align 8, !sec !{!"private", !"private"}
  %cmp7 = icmp ne ptr %16, null, !sec !{!"private"}
  br i1 %cmp7, label %while.body, label %while.end, !sec !{!"private"}

while.body:                                       ; preds = %while.cond, !sec !{!"private"}
  br label %for.cond8, !sec !{!"public"}

for.cond8:                                        ; preds = %for.inc23, %while.body, !sec !{!"private"}
  %17 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %18 = load ptr, ptr %n, align 8, !sec !{!"private", !"private"}
  %num_keys9 = getelementptr inbounds %struct.node, ptr %18, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %19 = load i64, ptr %num_keys9, align 8, !sec !{!"private", !"private"}
  %cmp10 = icmp ult i64 %17, %19, !sec !{!"private"}
  br i1 %cmp10, label %land.rhs11, label %land.end15, !sec !{!"private"}

land.rhs11:                                       ; preds = %for.cond8, !sec !{!"private"}
  %20 = load ptr, ptr %n, align 8, !sec !{!"private", !"private"}
  %keys12 = getelementptr inbounds %struct.node, ptr %20, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %21 = load ptr, ptr %keys12, align 8, !sec !{!"private", !"private"}
  %22 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx13 = getelementptr inbounds i64, ptr %21, i64 %22, !sec !{!"private", !"private", !"private"}
  %23 = load i64, ptr %arrayidx13, align 8, !sec !{!"private", !"private"}
  %24 = load i64, ptr %key_end.addr, align 8, !sec !{!"private", !"private"}
  %cmp14 = icmp ule i64 %23, %24, !sec !{!"private"}
  br label %land.end15, !sec !{!"public"}

land.end15:                                       ; preds = %land.rhs11, %for.cond8, !sec !{!"private"}
  %25 = phi i1 [ false, %for.cond8 ], [ %cmp14, %land.rhs11 ], !sec !{!"private"}
  br i1 %25, label %for.body16, label %for.end25, !sec !{!"private"}

for.body16:                                       ; preds = %land.end15, !sec !{!"private"}
  %26 = load ptr, ptr %n, align 8, !sec !{!"private", !"private"}
  %keys17 = getelementptr inbounds %struct.node, ptr %26, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %27 = load ptr, ptr %keys17, align 8, !sec !{!"private", !"private"}
  %28 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx18 = getelementptr inbounds i64, ptr %27, i64 %28, !sec !{!"private", !"private", !"private"}
  %29 = load i64, ptr %arrayidx18, align 8, !sec !{!"private", !"private"}
  %30 = load ptr, ptr %returned_keys.addr, align 8, !sec !{!"private", !"private"}
  %31 = load i64, ptr %num_found, align 8, !sec !{!"private", !"private"}
  %arrayidx19 = getelementptr inbounds i64, ptr %30, i64 %31, !sec !{!"private", !"private", !"private"}
  store i64 %29, ptr %arrayidx19, align 8, !sec !{!"private", !"private"}
  %32 = load ptr, ptr %n, align 8, !sec !{!"private", !"private"}
  %pointers = getelementptr inbounds %struct.node, ptr %32, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %33 = load ptr, ptr %pointers, align 8, !sec !{!"private", !"private"}
  %34 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx20 = getelementptr inbounds ptr, ptr %33, i64 %34, !sec !{!"private", !"private", !"private"}
  %35 = load ptr, ptr %arrayidx20, align 8, !sec !{!"private", !"private"}
  %36 = load ptr, ptr %returned_pointers.addr, align 8, !sec !{!"private", !"private"}
  %37 = load i64, ptr %num_found, align 8, !sec !{!"private", !"private"}
  %arrayidx21 = getelementptr inbounds ptr, ptr %36, i64 %37, !sec !{!"private", !"private", !"private"}
  store ptr %35, ptr %arrayidx21, align 8, !sec !{!"private", !"private"}
  %38 = load i64, ptr %num_found, align 8, !sec !{!"private", !"private"}
  %inc22 = add i64 %38, 1, !sec !{!"private"}
  store i64 %inc22, ptr %num_found, align 8, !sec !{!"private", !"private"}
  br label %for.inc23, !sec !{!"public"}

for.inc23:                                        ; preds = %for.body16, !sec !{!"private"}
  %39 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %inc24 = add i64 %39, 1, !sec !{!"private"}
  store i64 %inc24, ptr %i, align 8, !sec !{!"private", !"private"}
  br label %for.cond8, !llvm.loop !18, !sec !{!"public"}

for.end25:                                        ; preds = %land.end15, !sec !{!"private"}
  %40 = load ptr, ptr %n, align 8, !sec !{!"private", !"private"}
  %pointers26 = getelementptr inbounds %struct.node, ptr %40, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %41 = load ptr, ptr %pointers26, align 8, !sec !{!"private", !"private"}
  %42 = load i64, ptr @order, align 8, !sec !{!"private", !"private"}
  %sub = sub i64 %42, 1, !sec !{!"private"}
  %arrayidx27 = getelementptr inbounds ptr, ptr %41, i64 %sub, !sec !{!"private", !"private", !"private"}
  %43 = load ptr, ptr %arrayidx27, align 8, !sec !{!"private", !"private"}
  store ptr %43, ptr %n, align 8, !sec !{!"private", !"private"}
  store i64 0, ptr %i, align 8, !sec !{!"public", !"private"}
  br label %while.cond, !llvm.loop !19, !sec !{!"public"}

while.end:                                        ; preds = %while.cond, !sec !{!"private"}
  %44 = load i64, ptr %num_found, align 8, !sec !{!"private", !"private"}
  store i64 %44, ptr %retval, align 8, !sec !{!"private", !"private"}
  br label %return, !sec !{!"public"}

return:                                           ; preds = %while.end, %if.then5, %if.then, !sec !{!"private"}
  %45 = load i64, ptr %retval, align 8, !sec !{!"private", !"private"}
  ret i64 %45, !sec !{!"private"}
}

; Function Attrs: nocallback nofree nosync nounwind willreturn
; This had to be altered to remove the .p0 suffix otherwise clang complained
declare !sec !{!"void", !"public", !{!"public"}} void @llvm.stackrestore(ptr) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @find_leaf(ptr noundef %root, i64 noundef %key) #0 !sec !{!"private", !"private", !{!"private", !"private"}} {
entry:                                            ; !sec !{!"private"}
  %retval = alloca ptr, align 8, !sec !{!"private"}
  %root.addr = alloca ptr, align 8, !sec !{!"private"}
  %key.addr = alloca i64, align 8, !sec !{!"private"}
  %i = alloca i64, align 8, !sec !{!"private"}
  %c = alloca ptr, align 8, !sec !{!"private"}
  store ptr %root, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  store i64 %key, ptr %key.addr, align 8, !sec !{!"private", !"private"}
  %0 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %cmp = icmp eq ptr %0, null, !sec !{!"private"}
  br i1 %cmp, label %if.then, label %if.end, !sec !{!"private"}

if.then:                                          ; preds = %entry, !sec !{!"private"}
  %1 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  store ptr %1, ptr %retval, align 8, !sec !{!"private", !"private"}
  br label %return, !sec !{!"public"}

if.end:                                           ; preds = %entry, !sec !{!"private"}
  store i64 0, ptr %i, align 8, !sec !{!"public", !"private"}
  %2 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  store ptr %2, ptr %c, align 8, !sec !{!"private", !"private"}
  br label %while.cond, !sec !{!"public"}

while.cond:                                       ; preds = %while.end, %if.end, !sec !{!"private"}
  %3 = load ptr, ptr %c, align 8, !sec !{!"private", !"private"}
  %is_leaf = getelementptr inbounds %struct.node, ptr %3, i32 0, i32 3, !sec !{!"private", !"private", !"public", !"public"}
  %4 = load i8, ptr %is_leaf, align 8, !sec !{!"private", !"private"}
  %tobool = trunc i8 %4 to i1, !sec !{!"private"}
  %lnot = xor i1 %tobool, true, !sec !{!"private"}
  br i1 %lnot, label %while.body, label %while.end8, !sec !{!"private"}

while.body:                                       ; preds = %while.cond, !sec !{!"private"}
  store i64 0, ptr %i, align 8, !sec !{!"public", !"private"}
  br label %while.cond1, !sec !{!"public"}

while.cond1:                                      ; preds = %if.end6, %while.body, !sec !{!"private"}
  %5 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %6 = load ptr, ptr %c, align 8, !sec !{!"private", !"private"}
  %num_keys = getelementptr inbounds %struct.node, ptr %6, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %7 = load i64, ptr %num_keys, align 8, !sec !{!"private", !"private"}
  %cmp2 = icmp ult i64 %5, %7, !sec !{!"private"}
  br i1 %cmp2, label %while.body3, label %while.end, !sec !{!"private"}

while.body3:                                      ; preds = %while.cond1, !sec !{!"private"}
  %8 = load i64, ptr %key.addr, align 8, !sec !{!"private", !"private"}
  %9 = load ptr, ptr %c, align 8, !sec !{!"private", !"private"}
  %keys = getelementptr inbounds %struct.node, ptr %9, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %10 = load ptr, ptr %keys, align 8, !sec !{!"private", !"private"}
  %11 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx = getelementptr inbounds i64, ptr %10, i64 %11, !sec !{!"private", !"private", !"private"}
  %12 = load i64, ptr %arrayidx, align 8, !sec !{!"private", !"private"}
  %cmp4 = icmp uge i64 %8, %12, !sec !{!"private"}
  br i1 %cmp4, label %if.then5, label %if.else, !sec !{!"private"}

if.then5:                                         ; preds = %while.body3, !sec !{!"private"}
  %13 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %inc = add i64 %13, 1, !sec !{!"private"}
  store i64 %inc, ptr %i, align 8, !sec !{!"private", !"private"}
  br label %if.end6, !sec !{!"public"}

if.else:                                          ; preds = %while.body3, !sec !{!"private"}
  br label %while.end, !sec !{!"public"}

if.end6:                                          ; preds = %if.then5, !sec !{!"private"}
  br label %while.cond1, !llvm.loop !20, !sec !{!"public"}

while.end:                                        ; preds = %if.else, %while.cond1, !sec !{!"private"}
  %14 = load ptr, ptr %c, align 8, !sec !{!"private", !"private"}
  %pointers = getelementptr inbounds %struct.node, ptr %14, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %15 = load ptr, ptr %pointers, align 8, !sec !{!"private", !"private"}
  %16 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx7 = getelementptr inbounds ptr, ptr %15, i64 %16, !sec !{!"private", !"private", !"private"}
  %17 = load ptr, ptr %arrayidx7, align 8, !sec !{!"private", !"private"}
  store ptr %17, ptr %c, align 8, !sec !{!"private", !"private"}
  br label %while.cond, !llvm.loop !21, !sec !{!"public"}

while.end8:                                       ; preds = %while.cond, !sec !{!"private"}
  %18 = load ptr, ptr %c, align 8, !sec !{!"private", !"private"}
  store ptr %18, ptr %retval, align 8, !sec !{!"private", !"private"}
  br label %return, !sec !{!"public"}

return:                                           ; preds = %while.end8, %if.then, !sec !{!"private"}
  %19 = load ptr, ptr %retval, align 8, !sec !{!"private", !"private"}
  ret ptr %19, !sec !{!"private"}
}

;? cut
;? Purpose: Calculate midpoint for B-tree node splitting
;?
;? Return value analysis:
;?   - Type: i64
;?   - Semantic meaning: Index position to split a node
;?   - Data it holds: Computed split index based on node size
;?   - Security label: private
;?   - Rationale: This is an internal tree structure calculation that should not leak information about tree organization
;?
;? Parameter 1 (length):
;?   - Type: i64
;?   - Semantic meaning: Size/length of node being split
;?   - Usage in function: Used to compute midpoint (length/2 or (length/2)+1)
;?   - Data it holds: Node size derived from @order
;?   - Security label: private
;?   - Rationale: This is derived from @order which is now private; the split calculation is an internal tree operation
;?
;? Min-PC: private
;? Rationale: This is a pure computational function on private data with no I/O
; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @cut(i64 noundef %length) #0 !sec !{!"private", !"private", !{!"private"}} {
entry:                                            ; !sec !{!"private"}
  %retval = alloca i64, align 8, !sec !{!"private"}
  %length.addr = alloca i64, align 8, !sec !{!"private"}
  store i64 %length, ptr %length.addr, align 8, !sec !{!"private", !"private"}
  %0 = load i64, ptr %length.addr, align 8, !sec !{!"private", !"private"}
  %rem = urem i64 %0, 2, !sec !{!"private"}
  %cmp = icmp eq i64 %rem, 0, !sec !{!"private"}
  br i1 %cmp, label %if.then, label %if.else, !sec !{!"private"}

if.then:                                          ; preds = %entry, !sec !{!"private"}
  %1 = load i64, ptr %length.addr, align 8, !sec !{!"private", !"private"}
  %div = udiv i64 %1, 2, !sec !{!"private"}
  store i64 %div, ptr %retval, align 8, !sec !{!"private", !"private"}
  br label %return, !sec !{!"public"}

if.else:                                          ; preds = %entry, !sec !{!"private"}
  %2 = load i64, ptr %length.addr, align 8, !sec !{!"private", !"private"}
  %div1 = udiv i64 %2, 2, !sec !{!"private"}
  %add = add i64 %div1, 1, !sec !{!"private"}
  store i64 %add, ptr %retval, align 8, !sec !{!"private", !"private"}
  br label %return, !sec !{!"public"}

return:                                           ; preds = %if.else, %if.then, !sec !{!"private"}
  %3 = load i64, ptr %retval, align 8, !sec !{!"private", !"private"}
  ret i64 %3, !sec !{!"private"}
}

; Function Attrs: noinline nounwind optnone uwtable
;? alloc_node
;? Purpose: Allocate a B-tree node from the free list or system memory
;?
;? Return value analysis:
;?   - Type: ptr (pointer to struct.node)
;?   - Semantic meaning: Address of a freshly allocated, zero-initialized tree node
;?   - Data it holds: Points to private tree node (part of tree data structure)
;?   - Security label: private
;?   - Rationale: Returns node that will become part of private tree structure
;?
;? Min-PC: private
;? Rationale: Matches return type. Now that posix_memalign is nosec, allocate() and allocate_align64()
;?            can be called from private PC contexts without constraint violations.
; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @alloc_node() #0 !sec !{!"private", !"private", !{}} {
entry:                                            ; !sec !{!"private"}
  %n = alloca ptr, align 8, !sec !{!"private"}
  %i = alloca i64, align 8, !sec !{!"private"}
  %nd = alloca ptr, align 8, !sec !{!"private"}
  %0 = load ptr, ptr @free_nodes, align 8, !sec !{!"private", !"private"}
  %tobool = icmp ne ptr %0, null, !sec !{!"private"}
  br i1 %tobool, label %if.end5, label %if.then, !sec !{!"private"}

if.then:                                          ; preds = %entry, !sec !{!"private"}
  %call = call ptr @allocate(i64 noundef 1048576, i64 noundef 2097152), !sec !{!"call", !"private", !{!"private", !"private"}}
  store ptr %call, ptr %n, align 8, !sec !{!"private", !"private"}
  %1 = load ptr, ptr %n, align 8, !sec !{!"private", !"private"}
  %cmp = icmp eq ptr %1, null, !sec !{!"private"}
  br i1 %cmp, label %if.then1, label %if.end, !sec !{!"private"}

if.then1:                                         ; preds = %if.then, !sec !{!"private"}
  call void @exit(i32 noundef 1) #7, !sec !{!"call", !"void", !{!"public"}}
  unreachable

if.end:                                           ; preds = %if.then1, %if.then, !sec !{!"private"}
  store i64 0, ptr %i, align 8, !sec !{!"public", !"private"}
  br label %for.cond, !sec !{!"public"}

for.cond:                                         ; preds = %for.inc, %if.end, !sec !{!"private"}
  %2 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %cmp3 = icmp ult i64 %2, 18724, !sec !{!"private"}
  br i1 %cmp3, label %for.body, label %for.end, !sec !{!"private"}

for.body:                                         ; preds = %for.cond, !sec !{!"private"}
  %3 = load ptr, ptr @free_nodes, align 8, !sec !{!"private", !"private"}
  %4 = load ptr, ptr %n, align 8, !sec !{!"private", !"private"}
  %5 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx = getelementptr inbounds %struct.node, ptr %4, i64 %5, !sec !{!"private", !"private", !"private"}
  %next = getelementptr inbounds %struct.node, ptr %arrayidx, i32 0, i32 6, !sec !{!"private", !"private", !"public", !"public"}
  store ptr %3, ptr %next, align 8, !sec !{!"private", !"private"}
  %6 = load ptr, ptr %n, align 8, !sec !{!"private", !"private"}
  %7 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx4 = getelementptr inbounds %struct.node, ptr %6, i64 %7, !sec !{!"private", !"private", !"private"}
  store ptr %arrayidx4, ptr @free_nodes, align 8, !sec !{!"private", !"private"}
  br label %for.inc, !sec !{!"public"}

for.inc:                                          ; preds = %for.body, !sec !{!"private"}
  %8 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %inc = add i64 %8, 1, !sec !{!"private"}
  store i64 %inc, ptr %i, align 8, !sec !{!"private", !"private"}
  br label %for.cond, !llvm.loop !22, !sec !{!"public"}

for.end:                                          ; preds = %for.cond, !sec !{!"private"}
  br label %if.end5, !sec !{!"public"}

if.end5:                                          ; preds = %for.end, %entry, !sec !{!"private"}
  %9 = load ptr, ptr @free_nodes, align 8, !sec !{!"private", !"private"}
  store ptr %9, ptr %nd, align 8, !sec !{!"private", !"private"}
  %10 = load ptr, ptr %nd, align 8, !sec !{!"private", !"private"}
  %next6 = getelementptr inbounds %struct.node, ptr %10, i32 0, i32 6, !sec !{!"private", !"private", !"public", !"public"}
  %11 = load ptr, ptr %next6, align 8, !sec !{!"private", !"private"}
  store ptr %11, ptr @free_nodes, align 8, !sec !{!"private", !"private"}
  %12 = load ptr, ptr %nd, align 8, !sec !{!"private", !"private"}
  call void @llvm.memset.p0.i64(ptr align 8 %12, i8 0, i64 8, i1 false), !sec !{!"call", !"void", !{!"private", !"public", !"public", !"public"}}
  %13 = load ptr, ptr %nd, align 8, !sec !{!"private", !"private"}
  ret ptr %13, !sec !{!"private"}
}

;? allocate
;? Purpose: Allocate aligned memory for B-tree structures
;?
;? Return value analysis:
;?   - Type: ptr
;?   - Semantic meaning: Pointer to allocated memory
;?   - Data it holds: Address of private tree structure memory
;?   - Security label: private
;?   - Rationale: Returns pointers to memory that will hold private tree nodes
;?
;? Parameter 1 (size):
;?   - Type: i64
;?   - Semantic meaning: Size of memory to allocate
;?   - Usage in function: Passed to posix_memalign, used to update @allocator_stat
;?   - Data it holds: Size derived from private tree parameters (@order)
;?   - Security label: private
;?   - Rationale: Size is often derived from @order which is private
;?
;? Parameter 2 (alignment):
;?   - Type: i64
;?   - Semantic meaning: Memory alignment requirement
;?   - Usage in function: Passed to posix_memalign
;?   - Data it holds: Alignment value (often constant)
;?   - Security label: private
;?   - Rationale: Function needs to be callable from private contexts
;?
;? Min-PC: private
;? Rationale: Core allocation function for private tree structures, updates private
;? @allocator_stat counter, needs to be callable from private control flow
; Function Attrs: noinline nounwind optnone uwtable
define internal ptr @allocate(i64 noundef %size, i64 noundef %alignment) #0 !sec !{!"private", !"private", !{!"private", !"private"}} {
entry:                                            ; !sec !{!"private"}
  %size.addr = alloca i64, align 8, !sec !{!"private"}
  %alignment.addr = alloca i64, align 8, !sec !{!"private"}
  %memptr = alloca ptr, align 8, !sec !{!"private"}
  store i64 %size, ptr %size.addr, align 8, !sec !{!"private", !"private"}
  store i64 %alignment, ptr %alignment.addr, align 8, !sec !{!"private", !"private"}
  %0 = load i64, ptr %alignment.addr, align 8, !sec !{!"private", !"private"}
  %1 = load i64, ptr %size.addr, align 8, !sec !{!"private", !"private"}
  %call = call i32 @posix_memalign(ptr noundef %memptr, i64 noundef %0, i64 noundef %1) #8, !sec !{!"call", !"private", !{!"private", !"private", !"private"}}
  %tobool = icmp ne i32 %call, 0, !sec !{!"private"}
  br i1 %tobool, label %if.then, label %if.end, !sec !{!"private"}

if.then:                                          ; preds = %entry, !sec !{!"private"}
  call void @exit(i32 noundef 1) #7, !sec !{!"call", !"void", !{!"public"}}
  unreachable

if.end:                                           ; preds = %if.then, %entry, !sec !{!"private"}
  %2 = load i64, ptr %size.addr, align 8, !sec !{!"private", !"private"}
  %3 = load i64, ptr @allocator_stat, align 8, !sec !{!"private", !"private"}
  %add = add i64 %3, %2, !sec !{!"private"}
  store i64 %add, ptr @allocator_stat, align 8, !sec !{!"private", !"private"}
  %4 = load ptr, ptr %memptr, align 8, !sec !{!"private", !"private"}
  %5 = load i64, ptr %size.addr, align 8, !sec !{!"private", !"private"}
  call void @llvm.memset.p0.i64(ptr align 1 %4, i8 0, i64 %5, i1 false), !sec !{!"call", !"void", !{!"private", !"private", !"private", !"public"}}
  %6 = load ptr, ptr %memptr, align 8, !sec !{!"private", !"private"}
  ret ptr %6, !sec !{!"private"}
}

declare !sec !{!"private", !"private", !{!"public", !"public", !"..."}} i32 @fprintf(ptr noundef, ptr noundef, ...) #1

;? Made exit nosec for old error handling branches (idk how else to deal with them)
; Function Attrs: noreturn nounwind
declare !sec !{!"void", !"private", !{!"public"}} void @exit(i32 noundef) #3

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare !sec !{!"void", !"private", !{!"private", !"public", !"public", !"public"}} void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @free_node(ptr noundef %n) #0 !sec !{!"void", !"private", !{!"private"}} {
entry:                                            ; !sec !{!"private"}
  %n.addr = alloca ptr, align 8, !sec !{!"private"}
  store ptr %n, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %0 = load ptr, ptr @free_nodes, align 8, !sec !{!"private", !"private"}
  %1 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %next = getelementptr inbounds %struct.node, ptr %1, i32 0, i32 6, !sec !{!"private", !"private", !"public", !"public"}
  store ptr %0, ptr %next, align 8, !sec !{!"private", !"private"}
  %2 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  store ptr %2, ptr @free_nodes, align 8, !sec !{!"private", !"private"}
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
;? alloc_record
;? Purpose: Allocate a record from the free list or system memory
;?
;? Return value analysis:
;?   - Type: ptr (pointer to struct.record)
;?   - Semantic meaning: Address of a freshly allocated, zero-initialized record
;?   - Data it holds: Points to private record (will hold tree data)
;?   - Security label: private
;?   - Rationale: Returns record that will become part of private tree structure
;?
;? Min-PC: private
;? Rationale: Matches return type. Now that posix_memalign is nosec, allocate() can be called
;?            from private PC contexts. Error handling has been removed.
define dso_local ptr @alloc_record() #0 !sec !{!"private", !"private", !{}} {
entry:                                            ; !sec !{!"private"}
  %r = alloca ptr, align 8, !sec !{!"private"}
  %i = alloca i64, align 8, !sec !{!"private"}
  %rec = alloca ptr, align 8, !sec !{!"private"}
  %0 = load ptr, ptr @free_recs, align 8, !sec !{!"private", !"private"}
  %tobool = icmp ne ptr %0, null, !sec !{!"private"}
  br i1 %tobool, label %if.end5, label %if.then, !sec !{!"private"}

if.then:                                          ; preds = %entry, !sec !{!"private"}
  %call = call ptr @allocate(i64 noundef 1048576, i64 noundef 2097152), !sec !{!"call", !"private", !{!"private", !"private"}}
  store ptr %call, ptr %r, align 8, !sec !{!"private", !"private"}
  %1 = load ptr, ptr %r, align 8, !sec !{!"private", !"private"}
  %cmp = icmp eq ptr %1, null, !sec !{!"private"}
  br i1 %cmp, label %if.then1, label %if.end, !sec !{!"private"}

if.then1:                                         ; preds = %if.then, !sec !{!"private"}
  call void @exit(i32 noundef 1) #7, !sec !{!"call", !"void", !{!"public"}}
  unreachable

if.end:                                           ; preds = %if.then, %if.then1, !sec !{!"private"}
  store i64 0, ptr %i, align 8, !sec !{!"public", !"private"}
  br label %for.cond, !sec !{!"public"}

for.cond:                                         ; preds = %for.inc, %if.end, !sec !{!"private"}
  %2 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %cmp3 = icmp ult i64 %2, 32768, !sec !{!"private"}
  br i1 %cmp3, label %for.body, label %for.end, !sec !{!"private"}

for.body:                                         ; preds = %for.cond, !sec !{!"private"}
  %3 = load ptr, ptr @free_recs, align 8, !sec !{!"private", !"private"}
  %4 = load ptr, ptr %r, align 8, !sec !{!"private", !"private"}
  %5 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx = getelementptr inbounds %struct.record, ptr %4, i64 %5, !sec !{!"private", !"private", !"private"}
  %next = getelementptr inbounds %struct.record, ptr %arrayidx, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  store ptr %3, ptr %next, align 8, !sec !{!"private", !"private"}
  %6 = load ptr, ptr %r, align 8, !sec !{!"private", !"private"}
  %7 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx4 = getelementptr inbounds %struct.record, ptr %6, i64 %7, !sec !{!"private", !"private", !"private"}
  store ptr %arrayidx4, ptr @free_recs, align 8, !sec !{!"private", !"private"}
  br label %for.inc, !sec !{!"public"}

for.inc:                                          ; preds = %for.body, !sec !{!"private"}
  %8 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %inc = add i64 %8, 1, !sec !{!"private"}
  store i64 %inc, ptr %i, align 8, !sec !{!"private", !"private"}
  br label %for.cond, !llvm.loop !23, !sec !{!"public"}

for.end:                                          ; preds = %for.cond, !sec !{!"private"}
  br label %if.end5, !sec !{!"public"}

if.end5:                                          ; preds = %for.end, %entry, !sec !{!"private"}
  %9 = load ptr, ptr @free_recs, align 8, !sec !{!"private", !"private"}
  store ptr %9, ptr %rec, align 8, !sec !{!"private", !"private"}
  %10 = load ptr, ptr %rec, align 8, !sec !{!"private", !"private"}
  %next6 = getelementptr inbounds %struct.record, ptr %10, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %11 = load ptr, ptr %next6, align 8, !sec !{!"private", !"private"}
  store ptr %11, ptr @free_recs, align 8, !sec !{!"private", !"private"}
  %12 = load ptr, ptr %rec, align 8, !sec !{!"private", !"private"}
  call void @llvm.memset.p0.i64(ptr align 8 %12, i8 0, i64 32, i1 false), !sec !{!"call", !"void", !{!"private", !"public", !"public", !"public"}}
  %13 = load ptr, ptr %rec, align 8, !sec !{!"private", !"private"}
  ret ptr %13, !sec !{!"private"}
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @free_record(ptr noundef %r) #0 !sec !{!"void", !"private", !{!"private"}} {
entry:                                            ; !sec !{!"private"}
  %r.addr = alloca ptr, align 8, !sec !{!"private"}
  store ptr %r, ptr %r.addr, align 8, !sec !{!"private", !"private"}
  %0 = load ptr, ptr @free_recs, align 8, !sec !{!"private", !"private"}
  %1 = load ptr, ptr %r.addr, align 8, !sec !{!"private", !"private"}
  %next = getelementptr inbounds %struct.record, ptr %1, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  store ptr %0, ptr %next, align 8, !sec !{!"private", !"private"}
  %2 = load ptr, ptr %r.addr, align 8, !sec !{!"private", !"private"}
  store ptr %2, ptr @free_recs, align 8, !sec !{!"private", !"private"}
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @make_record(i64 noundef %value) #0 !sec !{!"private", !"private", !{!"private"}} {
entry:                                            ; !sec !{!"private"}
  %value.addr = alloca i64, align 8, !sec !{!"private"}
  %new_record = alloca ptr, align 8, !sec !{!"private"}
  store i64 %value, ptr %value.addr, align 8, !sec !{!"private", !"private"}
  %call = call ptr @alloc_record(), !sec !{!"call", !"private", !{}}
  store ptr %call, ptr %new_record, align 8, !sec !{!"private", !"private"}
  %0 = load ptr, ptr %new_record, align 8, !sec !{!"private", !"private"}
  %cmp = icmp eq ptr %0, null, !sec !{!"private"}
  br i1 %cmp, label %if.then, label %if.else, !sec !{!"private"}

if.then:                                          ; preds = %entry, !sec !{!"private"}
  call void @exit(i32 noundef 1) #7, !sec !{!"call", !"void", !{!"public"}}
  unreachable

if.else:                                          ; preds = %entry, %if.then, !sec !{!"private"}
  %1 = load i64, ptr %value.addr, align 8, !sec !{!"private", !"private"}
  %2 = load ptr, ptr %new_record, align 8, !sec !{!"private", !"private"}
  %value1 = getelementptr inbounds %struct.record, ptr %2, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  store i64 %1, ptr %value1, align 8, !sec !{!"private", !"private"}
  br label %if.end, !sec !{!"public"}

if.end:                                           ; preds = %if.else, !sec !{!"private"}
  %3 = load ptr, ptr %new_record, align 8, !sec !{!"private", !"private"}
  ret ptr %3, !sec !{!"private"}
}

; Function Attrs: cold
declare !sec !{!"private", !"private", !{!"public"}} void @perror(ptr noundef) #5

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @make_node() #0 !sec !{!"private", !"private", !{}} {
entry:                                            ; !sec !{!"private"}
  %new_node = alloca ptr, align 8, !sec !{!"private"}
  %call = call ptr @alloc_node(), !sec !{!"call", !"private", !{}}
  store ptr %call, ptr %new_node, align 8, !sec !{!"private", !"private"}
  %0 = load ptr, ptr %new_node, align 8, !sec !{!"private", !"private"}
  %cmp = icmp eq ptr %0, null, !sec !{!"private"}
  br i1 %cmp, label %if.then, label %if.end, !sec !{!"private"}

if.then:                                          ; preds = %entry, !sec !{!"private"}
  call void @exit(i32 noundef 1) #7, !sec !{!"call", !"void", !{!"public"}}
  unreachable

if.end:                                           ; preds = %if.then, %entry, !sec !{!"private"}
  %1 = load i64, ptr @order, align 8, !sec !{!"private", !"private"}
  %sub = sub i64 %1, 1, !sec !{!"private"}
  %mul = mul i64 %sub, 8, !sec !{!"private"}
  %call1 = call ptr @allocate_align64(i64 noundef %mul), !sec !{!"call", !"private", !{!"private"}}
  %2 = load ptr, ptr %new_node, align 8, !sec !{!"private", !"private"}
  %keys = getelementptr inbounds %struct.node, ptr %2, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  store ptr %call1, ptr %keys, align 8, !sec !{!"private", !"private"}
  %3 = load ptr, ptr %new_node, align 8, !sec !{!"private", !"private"}
  %keys2 = getelementptr inbounds %struct.node, ptr %3, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %4 = load ptr, ptr %keys2, align 8, !sec !{!"private", !"private"}
  %cmp3 = icmp eq ptr %4, null, !sec !{!"private"}
  br i1 %cmp3, label %if.then4, label %if.end5, !sec !{!"private"}

if.then4:                                         ; preds = %if.end, !sec !{!"private"}
 call void @exit(i32 noundef 1) #7, !sec !{!"call", !"void", !{!"public"}}
 unreachable

if.end5:                                          ; preds = %if.then4, %if.end, !sec !{!"private"}
  %5 = load i64, ptr @order, align 8, !sec !{!"private", !"private"}
  %mul6 = mul i64 %5, 8, !sec !{!"private"}
  %call7 = call ptr @allocate_align64(i64 noundef %mul6), !sec !{!"call", !"private", !{!"private"}}
  %6 = load ptr, ptr %new_node, align 8, !sec !{!"private", !"private"}
  %pointers = getelementptr inbounds %struct.node, ptr %6, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  store ptr %call7, ptr %pointers, align 8, !sec !{!"private", !"private"}
  %7 = load ptr, ptr %new_node, align 8, !sec !{!"private", !"private"}
  %pointers8 = getelementptr inbounds %struct.node, ptr %7, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %8 = load ptr, ptr %pointers8, align 8, !sec !{!"private", !"private"}
  %cmp9 = icmp eq ptr %8, null, !sec !{!"private"}
  br i1 %cmp9, label %if.then10, label %if.end11, !sec !{!"private"}

if.then10:                                        ; preds = %if.end5, !sec !{!"private"}
  call void @exit(i32 noundef 1) #7, !sec !{!"call", !"void", !{!"public"}}
  unreachable

if.end11:                                         ; preds = %if.then10, %if.end5, !sec !{!"private"}
  %9 = load ptr, ptr %new_node, align 8, !sec !{!"private", !"private"}
  %is_leaf = getelementptr inbounds %struct.node, ptr %9, i32 0, i32 3, !sec !{!"private", !"private", !"public", !"public"}
  store i8 0, ptr %is_leaf, align 8, !sec !{!"public", !"private"}
  %10 = load ptr, ptr %new_node, align 8, !sec !{!"private", !"private"}
  %num_keys = getelementptr inbounds %struct.node, ptr %10, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  store i64 0, ptr %num_keys, align 8, !sec !{!"public", !"private"}
  %11 = load ptr, ptr %new_node, align 8, !sec !{!"private", !"private"}
  %parent = getelementptr inbounds %struct.node, ptr %11, i32 0, i32 2, !sec !{!"private", !"private", !"public", !"public"}
  store ptr null, ptr %parent, align 8, !sec !{!"public", !"private"}
  %12 = load ptr, ptr %new_node, align 8, !sec !{!"private", !"private"}
  %next = getelementptr inbounds %struct.node, ptr %12, i32 0, i32 6, !sec !{!"private", !"private", !"public", !"public"}
  store ptr null, ptr %next, align 8, !sec !{!"public", !"private"}
  %13 = load ptr, ptr %new_node, align 8, !sec !{!"private", !"private"}
  ret ptr %13, !sec !{!"private"}
}

;? allocate_align64
;? Purpose: Allocate memory aligned to 64 bytes and return pointer
;?
;? Return value analysis:
;?   - Type: ptr
;?   - Semantic meaning: pointer to freshly-allocated memory (or null on failure)
;?   - Data it holds: caller-owned buffer memory (may contain private data)
;?   - Security label: private
;?   - Rationale: Memory returned can hold private data; callers expect to keep
;?     allocated buffers in protected memory when invoked from private contexts.
;?
;? Parameter 1 (%size):
;?   - Type: i64
;?   - Semantic meaning: allocation size in bytes
;?   - Usage in function: forwarded to posix_memalign and used for memset
;?   - Data it holds: numeric size (derived from @order or computed values)
;?   - Security label: private
;?   - Rationale: The size may be computed from private structures (e.g. tree
;?     order combined with sensitive indexes). Marking it private permits calls
;?     from private PC contexts without forcing declassification at call-sites.
;?
;? Min-PC: private
;? Rationale: This allocator is intended to be callable from private PC contexts
;?   (after marking posix_memalign as nosec). The allocator performs no IO that
;?   requires public PC and updates internal allocator statistics which are
;?   considered private.
; Function Attrs: noinline nounwind optnone uwtable
define internal ptr @allocate_align64(i64 noundef %size) #0 !sec !{!"private", !"private", !{!"private"}} {
entry:                                            ; !sec !{!"private"}
  %size.addr = alloca ptr, align 8, !sec !{!"private"}
  %memptr = alloca ptr, align 8, !sec !{!"private"}
  store i64 %size, ptr %size.addr, align 8, !sec !{!"private", !"private"}
  %0 = load i64, ptr %size.addr, align 8, !sec !{!"private", !"private"}
  %call = call i32 @posix_memalign(ptr noundef %memptr, i64 noundef 64, i64 noundef %0) #8, !sec !{!"call", !"private", !{!"private", !"public", !"private"}}
  %tobool = icmp ne i32 %call, 0, !sec !{!"private"}
  br i1 %tobool, label %if.then, label %if.end, !sec !{!"private"}

if.then:                                          ; preds = %entry, !sec !{!"private"}
  call void @exit(i32 noundef 1) #7, !sec !{!"call", !"void", !{!"public"}}
  unreachable

if.end:                                           ; preds = %if.then, %entry, !sec !{!"private"}
  %1 = load i64, ptr %size.addr, align 8, !sec !{!"private", !"private"}
  %2 = load i64, ptr @allocator_stat, align 8, !sec !{!"private", !"private"}
  %add = add i64 %2, %1, !sec !{!"private"}
  store i64 %add, ptr @allocator_stat, align 8, !sec !{!"private", !"private"}
  %3 = load ptr, ptr %memptr, align 8, !sec !{!"private", !"private"}
  %4 = load i64, ptr %size.addr, align 8, !sec !{!"private", !"private"}
  call void @llvm.memset.p0.i64(ptr align 1 %3, i8 0, i64 %4, i1 false), !sec !{!"call", !"void", !{!"private", !"private", !"private", !"public"}}
  %5 = load ptr, ptr %memptr, align 8, !sec !{!"private", !"private"}
  ret ptr %5, !sec !{!"private"}
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @make_leaf() #0 !sec !{!"private", !"private", !{}} {
entry:                                            ; !sec !{!"private"}
  %leaf = alloca ptr, align 8, !sec !{!"private"}
  %call = call ptr @make_node(), !sec !{!"call", !"private", !{}}
  store ptr %call, ptr %leaf, align 8, !sec !{!"private", !"private"}
  %0 = load ptr, ptr %leaf, align 8, !sec !{!"private", !"private"}
  %is_leaf = getelementptr inbounds %struct.node, ptr %0, i32 0, i32 3, !sec !{!"private", !"private", !"public", !"public"}
  store i8 1, ptr %is_leaf, align 8, !sec !{!"public", !"private"}
  %1 = load ptr, ptr %leaf, align 8, !sec !{!"private", !"private"}
  ret ptr %1, !sec !{!"private"}
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @get_left_index(ptr noundef %parent, ptr noundef %left) #0 !sec !{!"private", !"private", !{!"private", !"private"}} {
entry:                                            ; !sec !{!"private"}
  %parent.addr = alloca ptr, align 8, !sec !{!"private"}
  %left.addr = alloca ptr, align 8, !sec !{!"private"}
  %left_index = alloca i64, align 8, !sec !{!"private"}
  store ptr %parent, ptr %parent.addr, align 8, !sec !{!"private", !"private"}
  store ptr %left, ptr %left.addr, align 8, !sec !{!"private", !"private"}
  store i64 0, ptr %left_index, align 8, !sec !{!"public", !"private"}
  br label %while.cond, !sec !{!"public"}

while.cond:                                       ; preds = %while.body, %entry, !sec !{!"private"}
  %0 = load i64, ptr %left_index, align 8, !sec !{!"private", !"private"}
  %1 = load ptr, ptr %parent.addr, align 8, !sec !{!"private", !"private"}
  %num_keys = getelementptr inbounds %struct.node, ptr %1, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %2 = load i64, ptr %num_keys, align 8, !sec !{!"private", !"private"}
  %cmp = icmp ule i64 %0, %2, !sec !{!"private"}
  br i1 %cmp, label %land.rhs, label %land.end, !sec !{!"private"}

land.rhs:                                         ; preds = %while.cond, !sec !{!"private"}
  %3 = load ptr, ptr %parent.addr, align 8, !sec !{!"private", !"private"}
  %pointers = getelementptr inbounds %struct.node, ptr %3, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %4 = load ptr, ptr %pointers, align 8, !sec !{!"private", !"private"}
  %5 = load i64, ptr %left_index, align 8, !sec !{!"private", !"private"}
  %arrayidx = getelementptr inbounds ptr, ptr %4, i64 %5, !sec !{!"private", !"private", !"private"}
  %6 = load ptr, ptr %arrayidx, align 8, !sec !{!"private", !"private"}
  %7 = load ptr, ptr %left.addr, align 8, !sec !{!"private", !"private"}
  %cmp1 = icmp ne ptr %6, %7, !sec !{!"private"}
  br label %land.end, !sec !{!"public"}

land.end:                                         ; preds = %land.rhs, %while.cond, !sec !{!"private"}
  %8 = phi i1 [ false, %while.cond ], [ %cmp1, %land.rhs ], !sec !{!"private"}
  br i1 %8, label %while.body, label %while.end, !sec !{!"private"}

while.body:                                       ; preds = %land.end, !sec !{!"private"}
  %9 = load i64, ptr %left_index, align 8, !sec !{!"private", !"private"}
  %inc = add i64 %9, 1, !sec !{!"private"}
  store i64 %inc, ptr %left_index, align 8, !sec !{!"private", !"private"}
  br label %while.cond, !llvm.loop !24, !sec !{!"public"}

while.end:                                        ; preds = %land.end, !sec !{!"private"}
  %10 = load i64, ptr %left_index, align 8, !sec !{!"private", !"private"}
  ret i64 %10, !sec !{!"private"}
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @insert_into_leaf(ptr noundef %leaf, i64 noundef %key, ptr noundef %pointer) #0 !sec !{!"private", !"private", !{!"private", !"private", !"private"}} {
entry:                                            ; !sec !{!"private"}
  %leaf.addr = alloca ptr, align 8, !sec !{!"private"}
  %key.addr = alloca i64, align 8, !sec !{!"private"}
  %pointer.addr = alloca ptr, align 8, !sec !{!"private"}
  %i = alloca i64, align 8, !sec !{!"private"}
  %insertion_point = alloca i64, align 8, !sec !{!"private"}
  store ptr %leaf, ptr %leaf.addr, align 8, !sec !{!"private", !"private"}
  store i64 %key, ptr %key.addr, align 8, !sec !{!"private", !"private"}
  store ptr %pointer, ptr %pointer.addr, align 8, !sec !{!"private", !"private"}
  store i64 0, ptr %insertion_point, align 8, !sec !{!"public", !"private"}
  br label %while.cond, !sec !{!"public"}

while.cond:                                       ; preds = %while.body, %entry, !sec !{!"private"}
  %0 = load i64, ptr %insertion_point, align 8, !sec !{!"private", !"private"}
  %1 = load ptr, ptr %leaf.addr, align 8, !sec !{!"private", !"private"}
  %num_keys = getelementptr inbounds %struct.node, ptr %1, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %2 = load i64, ptr %num_keys, align 8, !sec !{!"private", !"private"}
  %cmp = icmp ult i64 %0, %2, !sec !{!"private"}
  br i1 %cmp, label %land.rhs, label %land.end, !sec !{!"private"}

land.rhs:                                         ; preds = %while.cond, !sec !{!"private"}
  %3 = load ptr, ptr %leaf.addr, align 8, !sec !{!"private", !"private"}
  %keys = getelementptr inbounds %struct.node, ptr %3, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %4 = load ptr, ptr %keys, align 8, !sec !{!"private", !"private"}
  %5 = load i64, ptr %insertion_point, align 8, !sec !{!"private", !"private"}
  %arrayidx = getelementptr inbounds i64, ptr %4, i64 %5, !sec !{!"private", !"private", !"private"}
  %6 = load i64, ptr %arrayidx, align 8, !sec !{!"private", !"private"}
  %7 = load i64, ptr %key.addr, align 8, !sec !{!"private", !"private"}
  %cmp1 = icmp ult i64 %6, %7, !sec !{!"private"}
  br label %land.end, !sec !{!"public"}

land.end:                                         ; preds = %land.rhs, %while.cond, !sec !{!"private"}
  %8 = phi i1 [ false, %while.cond ], [ %cmp1, %land.rhs ], !sec !{!"private"}
  br i1 %8, label %while.body, label %while.end, !sec !{!"private"}

while.body:                                       ; preds = %land.end, !sec !{!"private"}
  %9 = load i64, ptr %insertion_point, align 8, !sec !{!"private", !"private"}
  %inc = add i64 %9, 1, !sec !{!"private"}
  store i64 %inc, ptr %insertion_point, align 8, !sec !{!"private", !"private"}
  br label %while.cond, !llvm.loop !25, !sec !{!"public"}

while.end:                                        ; preds = %land.end, !sec !{!"private"}
  %10 = load ptr, ptr %leaf.addr, align 8, !sec !{!"private", !"private"}
  %num_keys2 = getelementptr inbounds %struct.node, ptr %10, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %11 = load i64, ptr %num_keys2, align 8, !sec !{!"private", !"private"}
  store i64 %11, ptr %i, align 8, !sec !{!"private", !"private"}
  br label %for.cond, !sec !{!"public"}

for.cond:                                         ; preds = %for.inc, %while.end, !sec !{!"private"}
  %12 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %13 = load i64, ptr %insertion_point, align 8, !sec !{!"private", !"private"}
  %cmp3 = icmp ugt i64 %12, %13, !sec !{!"private"}
  br i1 %cmp3, label %for.body, label %for.end, !sec !{!"private"}

for.body:                                         ; preds = %for.cond, !sec !{!"private"}
  %14 = load ptr, ptr %leaf.addr, align 8, !sec !{!"private", !"private"}
  %keys4 = getelementptr inbounds %struct.node, ptr %14, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %15 = load ptr, ptr %keys4, align 8, !sec !{!"private", !"private"}
  %16 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %sub = sub i64 %16, 1, !sec !{!"private"}
  %arrayidx5 = getelementptr inbounds i64, ptr %15, i64 %sub, !sec !{!"private", !"private", !"private"}
  %17 = load i64, ptr %arrayidx5, align 8, !sec !{!"private", !"private"}
  %18 = load ptr, ptr %leaf.addr, align 8, !sec !{!"private", !"private"}
  %keys6 = getelementptr inbounds %struct.node, ptr %18, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %19 = load ptr, ptr %keys6, align 8, !sec !{!"private", !"private"}
  %20 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx7 = getelementptr inbounds i64, ptr %19, i64 %20, !sec !{!"private", !"private", !"private"}
  store i64 %17, ptr %arrayidx7, align 8, !sec !{!"private", !"private"}
  %21 = load ptr, ptr %leaf.addr, align 8, !sec !{!"private", !"private"}
  %pointers = getelementptr inbounds %struct.node, ptr %21, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %22 = load ptr, ptr %pointers, align 8, !sec !{!"private", !"private"}
  %23 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %sub8 = sub i64 %23, 1, !sec !{!"private"}
  %arrayidx9 = getelementptr inbounds ptr, ptr %22, i64 %sub8, !sec !{!"private", !"private", !"private"}
  %24 = load ptr, ptr %arrayidx9, align 8, !sec !{!"private", !"private"}
  %25 = load ptr, ptr %leaf.addr, align 8, !sec !{!"private", !"private"}
  %pointers10 = getelementptr inbounds %struct.node, ptr %25, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %26 = load ptr, ptr %pointers10, align 8, !sec !{!"private", !"private"}
  %27 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx11 = getelementptr inbounds ptr, ptr %26, i64 %27, !sec !{!"private", !"private", !"private"}
  store ptr %24, ptr %arrayidx11, align 8, !sec !{!"private", !"private"}
  br label %for.inc, !sec !{!"public"}

for.inc:                                          ; preds = %for.body, !sec !{!"private"}
  %28 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %dec = add i64 %28, -1, !sec !{!"private"}
  store i64 %dec, ptr %i, align 8, !sec !{!"private", !"private"}
  br label %for.cond, !llvm.loop !26, !sec !{!"public"}

for.end:                                          ; preds = %for.cond, !sec !{!"private"}
  %29 = load i64, ptr %key.addr, align 8, !sec !{!"private", !"private"}
  %30 = load ptr, ptr %leaf.addr, align 8, !sec !{!"private", !"private"}
  %keys12 = getelementptr inbounds %struct.node, ptr %30, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %31 = load ptr, ptr %keys12, align 8, !sec !{!"private", !"private"}
  %32 = load i64, ptr %insertion_point, align 8, !sec !{!"private", !"private"}
  %arrayidx13 = getelementptr inbounds i64, ptr %31, i64 %32, !sec !{!"private", !"private", !"private"}
  store i64 %29, ptr %arrayidx13, align 8, !sec !{!"private", !"private"}
  %33 = load ptr, ptr %pointer.addr, align 8, !sec !{!"private", !"private"}
  %34 = load ptr, ptr %leaf.addr, align 8, !sec !{!"private", !"private"}
  %pointers14 = getelementptr inbounds %struct.node, ptr %34, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %35 = load ptr, ptr %pointers14, align 8, !sec !{!"private", !"private"}
  %36 = load i64, ptr %insertion_point, align 8, !sec !{!"private", !"private"}
  %arrayidx15 = getelementptr inbounds ptr, ptr %35, i64 %36, !sec !{!"private", !"private", !"private"}
  store ptr %33, ptr %arrayidx15, align 8, !sec !{!"private", !"private"}
  %37 = load ptr, ptr %leaf.addr, align 8, !sec !{!"private", !"private"}
  %num_keys16 = getelementptr inbounds %struct.node, ptr %37, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %38 = load i64, ptr %num_keys16, align 8, !sec !{!"private", !"private"}
  %inc17 = add i64 %38, 1, !sec !{!"private"}
  store i64 %inc17, ptr %num_keys16, align 8, !sec !{!"private", !"private"}
  %39 = load ptr, ptr %leaf.addr, align 8, !sec !{!"private", !"private"}
  ret ptr %39, !sec !{!"private"}
}

;? insert_into_leaf_after_splitting
;? Purpose: Insert key/pointer into leaf node, splitting it if necessary
;?
;? Return value analysis:
;?   - Type: ptr (pointer to potentially new root)
;?   - Semantic meaning: Root of tree after insertion (may be new root if split propagates)
;?   - Data it holds: Points to root node of private tree structure
;?   - Security label: private
;?   - Rationale: Returns tree node pointer, part of private tree structure
;?
;? Parameter 1 (root):
;?   - Type: ptr (pointer to struct.node)
;?   - Semantic meaning: Current root of tree
;?   - Usage in function: Passed to insert_into_parent if split occurs
;?   - Data it holds/points to: Private tree root node
;?   - Security label: private
;?   - Rationale: Tree nodes are private by default
;?
;? Parameter 2 (leaf):
;?   - Type: ptr (pointer to struct.node)
;?   - Semantic meaning: Leaf node to insert into
;?   - Usage in function: Accessed to read/write keys, pointers, num_keys
;?   - Data it holds/points to: Private leaf node with tree data
;?   - Security label: private
;?   - Rationale: Tree nodes are private by default
;?
;? Parameter 3 (key):
;?   - Type: i64 (key value)
;?   - Semantic meaning: Key to insert
;?   - Usage in function: Compared with existing keys, stored in tree
;?   - Data it holds: Key value for tree lookup
;?   - Security label: private
;?   - Rationale: Keys in private tree are private
;?
;? Parameter 4 (pointer):
;?   - Type: ptr (pointer to record)
;?   - Semantic meaning: Record to associate with key
;?   - Usage in function: Stored in leaf's pointer array
;?   - Data it holds/points to: Private record data
;?   - Security label: private
;?   - Rationale: Records in private tree are private
;?
;? Min-PC: private
;? Rationale: Matches return type. Now that posix_memalign is nosec, make_leaf() and 
;?            allocate_align64() can be called from private PC contexts. Error handling removed.
; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @insert_into_leaf_after_splitting(ptr noundef %root, ptr noundef %leaf, i64 noundef %key, ptr noundef %pointer) #0 !sec !{!"private", !"private", !{!"private", !"private", !"private", !"private"}} {
entry:                                            ; !sec !{!"private"}
  %root.addr = alloca ptr, align 8, !sec !{!"private"}
  %leaf.addr = alloca ptr, align 8, !sec !{!"private"}
  %key.addr = alloca i64, align 8, !sec !{!"private"}
  %pointer.addr = alloca ptr, align 8, !sec !{!"private"}
  %new_leaf = alloca ptr, align 8, !sec !{!"private"}
  %temp_keys = alloca ptr, align 8, !sec !{!"private"}
  %temp_pointers = alloca ptr, align 8, !sec !{!"private"}
  %insertion_index = alloca i64, align 8, !sec !{!"private"}
  %split = alloca i64, align 8, !sec !{!"private"}
  %new_key = alloca i64, align 8, !sec !{!"private"}
  %i = alloca i64, align 8, !sec !{!"private"}
  %j = alloca i64, align 8, !sec !{!"private"}
  store ptr %root, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  store ptr %leaf, ptr %leaf.addr, align 8, !sec !{!"private", !"private"}
  store i64 %key, ptr %key.addr, align 8, !sec !{!"private", !"private"}
  store ptr %pointer, ptr %pointer.addr, align 8, !sec !{!"private", !"private"}
  %call = call ptr @make_leaf(), !sec !{!"call", !"private", !{}}
  store ptr %call, ptr %new_leaf, align 8, !sec !{!"private", !"private"}
  %0 = load i64, ptr @order, align 8, !sec !{!"private", !"private"}
  %add = add i64 %0, 1, !sec !{!"private"}
  %mul = mul i64 %add, 8, !sec !{!"private"}
  %call1 = call ptr @allocate_align64(i64 noundef %mul), !sec !{!"call", !"private", !{!"private"}}
  store ptr %call1, ptr %temp_keys, align 8, !sec !{!"private", !"private"}
  %1 = load ptr, ptr %temp_keys, align 8, !sec !{!"private", !"private"}
  %cmp = icmp eq ptr %1, null, !sec !{!"private"}
  br i1 %cmp, label %if.then, label %if.end, !sec !{!"private"}

if.then:                                          ; preds = %entry, !sec !{!"private"}
  call void @exit(i32 noundef 1) #7, !sec !{!"call", !"void", !{!"public"}}
  unreachable

if.end:                                           ; preds = %entry, %if.then, !sec !{!"private"}
  %2 = load i64, ptr @order, align 8, !sec !{!"private", !"private"}
  %add2 = add i64 %2, 1, !sec !{!"private"}
  %mul3 = mul i64 %add2, 8, !sec !{!"private"}
  %call4 = call ptr @allocate_align64(i64 noundef %mul3), !sec !{!"call", !"private", !{!"private"}}
  store ptr %call4, ptr %temp_pointers, align 8, !sec !{!"private", !"private"}
  %3 = load ptr, ptr %temp_pointers, align 8, !sec !{!"private", !"private"}
  %cmp5 = icmp eq ptr %3, null, !sec !{!"private"}
  br i1 %cmp5, label %if.then6, label %if.end7, !sec !{!"private"}

if.then6:                                         ; preds = %if.end, !sec !{!"private"}
  call void @exit(i32 noundef 1) #7, !sec !{!"call", !"void", !{!"public"}}
  unreachable

if.end7:                                          ; preds = %if.end, %if.then6, !sec !{!"private"}
  store i64 0, ptr %insertion_index, align 8, !sec !{!"public", !"private"}
  br label %while.cond, !sec !{!"public"}

while.cond:                                       ; preds = %while.body, %if.end7, !sec !{!"private"}
  %4 = load i64, ptr %insertion_index, align 8, !sec !{!"private", !"private"}
  %5 = load i64, ptr @order, align 8, !sec !{!"private", !"private"}
  %sub = sub i64 %5, 1, !sec !{!"private"}
  %cmp8 = icmp ult i64 %4, %sub, !sec !{!"private"}
  br i1 %cmp8, label %land.rhs, label %land.end, !sec !{!"private"}

land.rhs:                                         ; preds = %while.cond, !sec !{!"private"}
  %6 = load ptr, ptr %leaf.addr, align 8, !sec !{!"private", !"private"}
  %keys = getelementptr inbounds %struct.node, ptr %6, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %7 = load ptr, ptr %keys, align 8, !sec !{!"private", !"private"}
  %8 = load i64, ptr %insertion_index, align 8, !sec !{!"private", !"private"}
  %arrayidx = getelementptr inbounds i64, ptr %7, i64 %8, !sec !{!"private", !"private", !"private"}
  %9 = load i64, ptr %arrayidx, align 8, !sec !{!"private", !"private"}
  %10 = load i64, ptr %key.addr, align 8, !sec !{!"private", !"private"}
  %cmp9 = icmp ult i64 %9, %10, !sec !{!"private"}
  br label %land.end, !sec !{!"public"}

land.end:                                         ; preds = %land.rhs, %while.cond, !sec !{!"private"}
  %11 = phi i1 [ false, %while.cond ], [ %cmp9, %land.rhs ], !sec !{!"private"}
  br i1 %11, label %while.body, label %while.end, !sec !{!"private"}

while.body:                                       ; preds = %land.end, !sec !{!"private"}
  %12 = load i64, ptr %insertion_index, align 8, !sec !{!"private", !"private"}
  %inc = add i64 %12, 1, !sec !{!"private"}
  store i64 %inc, ptr %insertion_index, align 8, !sec !{!"private", !"private"}
  br label %while.cond, !llvm.loop !27, !sec !{!"public"}

while.end:                                        ; preds = %land.end, !sec !{!"private"}
  store i64 0, ptr %i, align 8, !sec !{!"public", !"private"}
  store i64 0, ptr %j, align 8, !sec !{!"public", !"private"}
  br label %for.cond, !sec !{!"public"}

for.cond:                                         ; preds = %for.inc, %while.end, !sec !{!"private"}
  %13 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %14 = load ptr, ptr %leaf.addr, align 8, !sec !{!"private", !"private"}
  %num_keys = getelementptr inbounds %struct.node, ptr %14, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %15 = load i64, ptr %num_keys, align 8, !sec !{!"private", !"private"}
  %cmp10 = icmp ult i64 %13, %15, !sec !{!"private"}
  br i1 %cmp10, label %for.body, label %for.end, !sec !{!"private"}

for.body:                                         ; preds = %for.cond, !sec !{!"private"}
  %16 = load i64, ptr %j, align 8, !sec !{!"private", !"private"}
  %17 = load i64, ptr %insertion_index, align 8, !sec !{!"private", !"private"}
  %cmp11 = icmp eq i64 %16, %17, !sec !{!"private"}
  br i1 %cmp11, label %if.then12, label %if.end14, !sec !{!"private"}

if.then12:                                        ; preds = %for.body, !sec !{!"private"}
  %18 = load i64, ptr %j, align 8, !sec !{!"private", !"private"}
  %inc13 = add i64 %18, 1, !sec !{!"private"}
  store i64 %inc13, ptr %j, align 8, !sec !{!"private", !"private"}
  br label %if.end14, !sec !{!"public"}

if.end14:                                         ; preds = %if.then12, %for.body, !sec !{!"private"}
  %19 = load ptr, ptr %leaf.addr, align 8, !sec !{!"private", !"private"}
  %keys15 = getelementptr inbounds %struct.node, ptr %19, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %20 = load ptr, ptr %keys15, align 8, !sec !{!"private", !"private"}
  %21 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx16 = getelementptr inbounds i64, ptr %20, i64 %21, !sec !{!"private", !"private", !"private"}
  %22 = load i64, ptr %arrayidx16, align 8, !sec !{!"private", !"private"}
  %23 = load ptr, ptr %temp_keys, align 8, !sec !{!"private", !"private"}
  %24 = load i64, ptr %j, align 8, !sec !{!"private", !"private"}
  %arrayidx17 = getelementptr inbounds i64, ptr %23, i64 %24, !sec !{!"private", !"private", !"private"}
  store i64 %22, ptr %arrayidx17, align 8, !sec !{!"private", !"private"}
  %25 = load ptr, ptr %leaf.addr, align 8, !sec !{!"private", !"private"}
  %pointers = getelementptr inbounds %struct.node, ptr %25, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %26 = load ptr, ptr %pointers, align 8, !sec !{!"private", !"private"}
  %27 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx18 = getelementptr inbounds ptr, ptr %26, i64 %27, !sec !{!"private", !"private", !"private"}
  %28 = load ptr, ptr %arrayidx18, align 8, !sec !{!"private", !"private"}
  %29 = load ptr, ptr %temp_pointers, align 8, !sec !{!"private", !"private"}
  %30 = load i64, ptr %j, align 8, !sec !{!"private", !"private"}
  %arrayidx19 = getelementptr inbounds ptr, ptr %29, i64 %30, !sec !{!"private", !"private", !"private"}
  store ptr %28, ptr %arrayidx19, align 8, !sec !{!"private", !"private"}
  br label %for.inc, !sec !{!"public"}

for.inc:                                          ; preds = %if.end14, !sec !{!"private"}
  %31 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %inc20 = add i64 %31, 1, !sec !{!"private"}
  store i64 %inc20, ptr %i, align 8, !sec !{!"private", !"private"}
  %32 = load i64, ptr %j, align 8, !sec !{!"private", !"private"}
  %inc21 = add i64 %32, 1, !sec !{!"private"}
  store i64 %inc21, ptr %j, align 8, !sec !{!"private", !"private"}
  br label %for.cond, !llvm.loop !28, !sec !{!"public"}

for.end:                                          ; preds = %for.cond, !sec !{!"private"}
  %33 = load i64, ptr %key.addr, align 8, !sec !{!"private", !"private"}
  %34 = load ptr, ptr %temp_keys, align 8, !sec !{!"private", !"private"}
  %35 = load i64, ptr %insertion_index, align 8, !sec !{!"private", !"private"}
  %arrayidx22 = getelementptr inbounds i64, ptr %34, i64 %35, !sec !{!"private", !"private", !"private"}
  store i64 %33, ptr %arrayidx22, align 8, !sec !{!"private", !"private"}
  %36 = load ptr, ptr %pointer.addr, align 8, !sec !{!"private", !"private"}
  %37 = load ptr, ptr %temp_pointers, align 8, !sec !{!"private", !"private"}
  %38 = load i64, ptr %insertion_index, align 8, !sec !{!"private", !"private"}
  %arrayidx23 = getelementptr inbounds ptr, ptr %37, i64 %38, !sec !{!"private", !"private", !"private"}
  store ptr %36, ptr %arrayidx23, align 8, !sec !{!"private", !"private"}
  %39 = load ptr, ptr %leaf.addr, align 8, !sec !{!"private", !"private"}
  %num_keys24 = getelementptr inbounds %struct.node, ptr %39, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  store i64 0, ptr %num_keys24, align 8, !sec !{!"public", !"private"}
  %40 = load i64, ptr @order, align 8, !sec !{!"private", !"private"}
  %sub25 = sub i64 %40, 1, !sec !{!"private"}
  %call26 = call i64 @cut(i64 noundef %sub25), !sec !{!"call", !"private", !{!"private"}}
  store i64 %call26, ptr %split, align 8, !sec !{!"private", !"private"}
  store i64 0, ptr %i, align 8, !sec !{!"public", !"private"}
  br label %for.cond27, !sec !{!"public"}

for.cond27:                                       ; preds = %for.inc38, %for.end, !sec !{!"private"}
  %41 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %42 = load i64, ptr %split, align 8, !sec !{!"private", !"private"}
  %cmp28 = icmp ult i64 %41, %42, !sec !{!"private"}
  br i1 %cmp28, label %for.body29, label %for.end40, !sec !{!"private"}

for.body29:                                       ; preds = %for.cond27, !sec !{!"private"}
  %43 = load ptr, ptr %temp_pointers, align 8, !sec !{!"private", !"private"}
  %44 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx30 = getelementptr inbounds ptr, ptr %43, i64 %44, !sec !{!"private", !"private", !"private"}
  %45 = load ptr, ptr %arrayidx30, align 8, !sec !{!"private", !"private"}
  %46 = load ptr, ptr %leaf.addr, align 8, !sec !{!"private", !"private"}
  %pointers31 = getelementptr inbounds %struct.node, ptr %46, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %47 = load ptr, ptr %pointers31, align 8, !sec !{!"private", !"private"}
  %48 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx32 = getelementptr inbounds ptr, ptr %47, i64 %48, !sec !{!"private", !"private", !"private"}
  store ptr %45, ptr %arrayidx32, align 8, !sec !{!"private", !"private"}
  %49 = load ptr, ptr %temp_keys, align 8, !sec !{!"private", !"private"}
  %50 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx33 = getelementptr inbounds i64, ptr %49, i64 %50, !sec !{!"private", !"private", !"private"}
  %51 = load i64, ptr %arrayidx33, align 8, !sec !{!"private", !"private"}
  %52 = load ptr, ptr %leaf.addr, align 8, !sec !{!"private", !"private"}
  %keys34 = getelementptr inbounds %struct.node, ptr %52, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %53 = load ptr, ptr %keys34, align 8, !sec !{!"private", !"private"}
  %54 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx35 = getelementptr inbounds i64, ptr %53, i64 %54, !sec !{!"private", !"private", !"private"}
  store i64 %51, ptr %arrayidx35, align 8, !sec !{!"private", !"private"}
  %55 = load ptr, ptr %leaf.addr, align 8, !sec !{!"private", !"private"}
  %num_keys36 = getelementptr inbounds %struct.node, ptr %55, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %56 = load i64, ptr %num_keys36, align 8, !sec !{!"private", !"private"}
  %inc37 = add i64 %56, 1, !sec !{!"private"}
  store i64 %inc37, ptr %num_keys36, align 8, !sec !{!"private", !"private"}
  br label %for.inc38, !sec !{!"public"}

for.inc38:                                        ; preds = %for.body29, !sec !{!"private"}
  %57 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %inc39 = add i64 %57, 1, !sec !{!"private"}
  store i64 %inc39, ptr %i, align 8, !sec !{!"private", !"private"}
  br label %for.cond27, !llvm.loop !29, !sec !{!"public"}

for.end40:                                        ; preds = %for.cond27, !sec !{!"private"}
  %58 = load i64, ptr %split, align 8, !sec !{!"private", !"private"}
  store i64 %58, ptr %i, align 8, !sec !{!"private", !"private"}
  store i64 0, ptr %j, align 8, !sec !{!"public", !"private"}
  br label %for.cond41, !sec !{!"public"}

for.cond41:                                       ; preds = %for.inc52, %for.end40, !sec !{!"private"}
  %59 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %60 = load i64, ptr @order, align 8, !sec !{!"private", !"private"}
  %cmp42 = icmp ult i64 %59, %60, !sec !{!"private"}
  br i1 %cmp42, label %for.body43, label %for.end55, !sec !{!"private"}

for.body43:                                       ; preds = %for.cond41, !sec !{!"private"}
  %61 = load ptr, ptr %temp_pointers, align 8, !sec !{!"private", !"private"}
  %62 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx44 = getelementptr inbounds ptr, ptr %61, i64 %62, !sec !{!"private", !"private", !"private"}
  %63 = load ptr, ptr %arrayidx44, align 8, !sec !{!"private", !"private"}
  %64 = load ptr, ptr %new_leaf, align 8, !sec !{!"private", !"private"}
  %pointers45 = getelementptr inbounds %struct.node, ptr %64, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %65 = load ptr, ptr %pointers45, align 8, !sec !{!"private", !"private"}
  %66 = load i64, ptr %j, align 8, !sec !{!"private", !"private"}
  %arrayidx46 = getelementptr inbounds ptr, ptr %65, i64 %66, !sec !{!"private", !"private", !"private"}
  store ptr %63, ptr %arrayidx46, align 8, !sec !{!"private", !"private"}
  %67 = load ptr, ptr %temp_keys, align 8, !sec !{!"private", !"private"}
  %68 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx47 = getelementptr inbounds i64, ptr %67, i64 %68, !sec !{!"private", !"private", !"private"}
  %69 = load i64, ptr %arrayidx47, align 8, !sec !{!"private", !"private"}
  %70 = load ptr, ptr %new_leaf, align 8, !sec !{!"private", !"private"}
  %keys48 = getelementptr inbounds %struct.node, ptr %70, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %71 = load ptr, ptr %keys48, align 8, !sec !{!"private", !"private"}
  %72 = load i64, ptr %j, align 8, !sec !{!"private", !"private"}
  %arrayidx49 = getelementptr inbounds i64, ptr %71, i64 %72, !sec !{!"private", !"private", !"private"}
  store i64 %69, ptr %arrayidx49, align 8, !sec !{!"private", !"private"}
  %73 = load ptr, ptr %new_leaf, align 8, !sec !{!"private", !"private"}
  %num_keys50 = getelementptr inbounds %struct.node, ptr %73, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %74 = load i64, ptr %num_keys50, align 8, !sec !{!"private", !"private"}
  %inc51 = add i64 %74, 1, !sec !{!"private"}
  store i64 %inc51, ptr %num_keys50, align 8, !sec !{!"private", !"private"}
  br label %for.inc52, !sec !{!"public"}

for.inc52:                                        ; preds = %for.body43, !sec !{!"private"}
  %75 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %inc53 = add i64 %75, 1, !sec !{!"private"}
  store i64 %inc53, ptr %i, align 8, !sec !{!"private", !"private"}
  %76 = load i64, ptr %j, align 8, !sec !{!"private", !"private"}
  %inc54 = add i64 %76, 1, !sec !{!"private"}
  store i64 %inc54, ptr %j, align 8, !sec !{!"private", !"private"}
  br label %for.cond41, !llvm.loop !30, !sec !{!"public"}

for.end55:                                        ; preds = %for.cond41, !sec !{!"private"}
  %77 = load ptr, ptr %temp_pointers, align 8, !sec !{!"private", !"private"}
  call void @free(ptr noundef %77) #8, !sec !{!"public"}
  %78 = load ptr, ptr %temp_keys, align 8, !sec !{!"private", !"private"}
  call void @free(ptr noundef %78) #8, !sec !{!"public"}
  %79 = load ptr, ptr %leaf.addr, align 8, !sec !{!"private", !"private"}
  %pointers56 = getelementptr inbounds %struct.node, ptr %79, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %80 = load ptr, ptr %pointers56, align 8, !sec !{!"private", !"private"}
  %81 = load i64, ptr @order, align 8, !sec !{!"private", !"private"}
  %sub57 = sub i64 %81, 1, !sec !{!"private"}
  %arrayidx58 = getelementptr inbounds ptr, ptr %80, i64 %sub57, !sec !{!"private", !"private", !"private"}
  %82 = load ptr, ptr %arrayidx58, align 8, !sec !{!"private", !"private"}
  %83 = load ptr, ptr %new_leaf, align 8, !sec !{!"private", !"private"}
  %pointers59 = getelementptr inbounds %struct.node, ptr %83, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %84 = load ptr, ptr %pointers59, align 8, !sec !{!"private", !"private"}
  %85 = load i64, ptr @order, align 8, !sec !{!"private", !"private"}
  %sub60 = sub i64 %85, 1, !sec !{!"private"}
  %arrayidx61 = getelementptr inbounds ptr, ptr %84, i64 %sub60, !sec !{!"private", !"private", !"private"}
  store ptr %82, ptr %arrayidx61, align 8, !sec !{!"private", !"private"}
  %86 = load ptr, ptr %new_leaf, align 8, !sec !{!"private", !"private"}
  %87 = load ptr, ptr %leaf.addr, align 8, !sec !{!"private", !"private"}
  %pointers62 = getelementptr inbounds %struct.node, ptr %87, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %88 = load ptr, ptr %pointers62, align 8, !sec !{!"private", !"private"}
  %89 = load i64, ptr @order, align 8, !sec !{!"private", !"private"}
  %sub63 = sub i64 %89, 1, !sec !{!"private"}
  %arrayidx64 = getelementptr inbounds ptr, ptr %88, i64 %sub63, !sec !{!"private", !"private", !"private"}
  store ptr %86, ptr %arrayidx64, align 8, !sec !{!"private", !"private"}
  %90 = load ptr, ptr %leaf.addr, align 8, !sec !{!"private", !"private"}
  %num_keys65 = getelementptr inbounds %struct.node, ptr %90, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %91 = load i64, ptr %num_keys65, align 8, !sec !{!"private", !"private"}
  store i64 %91, ptr %i, align 8, !sec !{!"private", !"private"}
  br label %for.cond66, !sec !{!"public"}

for.cond66:                                       ; preds = %for.inc72, %for.end55, !sec !{!"private"}
  %92 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %93 = load i64, ptr @order, align 8, !sec !{!"private", !"private"}
  %sub67 = sub i64 %93, 1, !sec !{!"private"}
  %cmp68 = icmp ult i64 %92, %sub67, !sec !{!"private"}
  br i1 %cmp68, label %for.body69, label %for.end74, !sec !{!"private"}

for.body69:                                       ; preds = %for.cond66, !sec !{!"private"}
  %94 = load ptr, ptr %leaf.addr, align 8, !sec !{!"private", !"private"}
  %pointers70 = getelementptr inbounds %struct.node, ptr %94, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %95 = load ptr, ptr %pointers70, align 8, !sec !{!"private", !"private"}
  %96 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx71 = getelementptr inbounds ptr, ptr %95, i64 %96, !sec !{!"private", !"private", !"private"}
  store ptr null, ptr %arrayidx71, align 8, !sec !{!"public", !"private"}
  br label %for.inc72, !sec !{!"public"}

for.inc72:                                        ; preds = %for.body69, !sec !{!"private"}
  %97 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %inc73 = add i64 %97, 1, !sec !{!"private"}
  store i64 %inc73, ptr %i, align 8, !sec !{!"private", !"private"}
  br label %for.cond66, !llvm.loop !31, !sec !{!"public"}

for.end74:                                        ; preds = %for.cond66, !sec !{!"private"}
  %98 = load ptr, ptr %new_leaf, align 8, !sec !{!"private", !"private"}
  %num_keys75 = getelementptr inbounds %struct.node, ptr %98, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %99 = load i64, ptr %num_keys75, align 8, !sec !{!"private", !"private"}
  store i64 %99, ptr %i, align 8, !sec !{!"private", !"private"}
  br label %for.cond76, !sec !{!"public"}

for.cond76:                                       ; preds = %for.inc82, %for.end74, !sec !{!"private"}
  %100 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %101 = load i64, ptr @order, align 8, !sec !{!"private", !"private"}
  %sub77 = sub i64 %101, 1, !sec !{!"private"}
  %cmp78 = icmp ult i64 %100, %sub77, !sec !{!"private"}
  br i1 %cmp78, label %for.body79, label %for.end84, !sec !{!"private"}

for.body79:                                       ; preds = %for.cond76, !sec !{!"private"}
  %102 = load ptr, ptr %new_leaf, align 8, !sec !{!"private", !"private"}
  %pointers80 = getelementptr inbounds %struct.node, ptr %102, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %103 = load ptr, ptr %pointers80, align 8, !sec !{!"private", !"private"}
  %104 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx81 = getelementptr inbounds ptr, ptr %103, i64 %104, !sec !{!"private", !"private", !"private"}
  store ptr null, ptr %arrayidx81, align 8, !sec !{!"public", !"private"}
  br label %for.inc82, !sec !{!"public"}

for.inc82:                                        ; preds = %for.body79, !sec !{!"private"}
  %105 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %inc83 = add i64 %105, 1, !sec !{!"private"}
  store i64 %inc83, ptr %i, align 8, !sec !{!"private", !"private"}
  br label %for.cond76, !llvm.loop !32, !sec !{!"public"}

for.end84:                                        ; preds = %for.cond76, !sec !{!"private"}
  %106 = load ptr, ptr %leaf.addr, align 8, !sec !{!"private", !"private"}
  %parent = getelementptr inbounds %struct.node, ptr %106, i32 0, i32 2, !sec !{!"private", !"private", !"public", !"public"}
  %107 = load ptr, ptr %parent, align 8, !sec !{!"private", !"private"}
  %108 = load ptr, ptr %new_leaf, align 8, !sec !{!"private", !"private"}
  %parent85 = getelementptr inbounds %struct.node, ptr %108, i32 0, i32 2, !sec !{!"private", !"private", !"public", !"public"}
  store ptr %107, ptr %parent85, align 8, !sec !{!"private", !"private"}
  %109 = load ptr, ptr %new_leaf, align 8, !sec !{!"private", !"private"}
  %keys86 = getelementptr inbounds %struct.node, ptr %109, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %110 = load ptr, ptr %keys86, align 8, !sec !{!"private", !"private"}
  %arrayidx87 = getelementptr inbounds i64, ptr %110, i64 0, !sec !{!"private", !"private", !"public"}
  %111 = load i64, ptr %arrayidx87, align 8, !sec !{!"private", !"private"}
  store i64 %111, ptr %new_key, align 8, !sec !{!"private", !"private"}
  %112 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %113 = load ptr, ptr %leaf.addr, align 8, !sec !{!"private", !"private"}
  %114 = load i64, ptr %new_key, align 8, !sec !{!"private", !"private"}
  %115 = load ptr, ptr %new_leaf, align 8, !sec !{!"private", !"private"}
  %call88 = call ptr @insert_into_parent(ptr noundef %112, ptr noundef %113, i64 noundef %114, ptr noundef %115), !sec !{!"call", !"private", !{!"private", !"private", !"private", !"private"}}
  ret ptr %call88, !sec !{!"private"}
}

; Function Attrs: nounwind
declare void @free(ptr noundef) #6

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @insert_into_parent(ptr noundef %root, ptr noundef %left, i64 noundef %key, ptr noundef %right) #0 !sec !{!"private", !"private", !{!"private", !"private", !"private", !"private"}} {
entry:                                            ; !sec !{!"private"}
  %retval = alloca ptr, align 8, !sec !{!"private"}
  %root.addr = alloca ptr, align 8, !sec !{!"private"}
  %left.addr = alloca ptr, align 8, !sec !{!"private"}
  %key.addr = alloca i64, align 8, !sec !{!"private"}
  %right.addr = alloca ptr, align 8, !sec !{!"private"}
  %left_index = alloca i64, align 8, !sec !{!"private"}
  %parent = alloca ptr, align 8, !sec !{!"private"}
  store ptr %root, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  store ptr %left, ptr %left.addr, align 8, !sec !{!"private", !"private"}
  store i64 %key, ptr %key.addr, align 8, !sec !{!"private", !"private"}
  store ptr %right, ptr %right.addr, align 8, !sec !{!"private", !"private"}
  %0 = load ptr, ptr %left.addr, align 8, !sec !{!"private", !"private"}
  %parent1 = getelementptr inbounds %struct.node, ptr %0, i32 0, i32 2, !sec !{!"private", !"private", !"public", !"public"}
  %1 = load ptr, ptr %parent1, align 8, !sec !{!"private", !"private"}
  store ptr %1, ptr %parent, align 8, !sec !{!"private", !"private"}
  %2 = load ptr, ptr %parent, align 8, !sec !{!"private", !"private"}
  %cmp = icmp eq ptr %2, null, !sec !{!"private"}
  br i1 %cmp, label %if.then, label %if.end, !sec !{!"private"}

if.then:                                          ; preds = %entry, !sec !{!"private"}
  %3 = load ptr, ptr %left.addr, align 8, !sec !{!"private", !"private"}
  %4 = load i64, ptr %key.addr, align 8, !sec !{!"private", !"private"}
  %5 = load ptr, ptr %right.addr, align 8, !sec !{!"private", !"private"}
  %call = call ptr @insert_into_new_root(ptr noundef %3, i64 noundef %4, ptr noundef %5), !sec !{!"call", !"private", !{!"private", !"private", !"private"}}
  store ptr %call, ptr %retval, align 8, !sec !{!"private", !"private"}
  br label %return, !sec !{!"public"}

if.end:                                           ; preds = %entry, !sec !{!"private"}
  %6 = load ptr, ptr %parent, align 8, !sec !{!"private", !"private"}
  %7 = load ptr, ptr %left.addr, align 8, !sec !{!"private", !"private"}
  %call2 = call i64 @get_left_index(ptr noundef %6, ptr noundef %7), !sec !{!"call", !"private", !{!"private", !"private"}}
  store i64 %call2, ptr %left_index, align 8, !sec !{!"private", !"private"}
  %8 = load ptr, ptr %parent, align 8, !sec !{!"private", !"private"}
  %num_keys = getelementptr inbounds %struct.node, ptr %8, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %9 = load i64, ptr %num_keys, align 8, !sec !{!"private", !"private"}
  %10 = load i64, ptr @order, align 8, !sec !{!"private", !"private"}
  %sub = sub i64 %10, 1, !sec !{!"private"}
  %cmp3 = icmp ult i64 %9, %sub, !sec !{!"private"}
  br i1 %cmp3, label %if.then4, label %if.end6, !sec !{!"private"}

if.then4:                                         ; preds = %if.end, !sec !{!"private"}
  %11 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %12 = load ptr, ptr %parent, align 8, !sec !{!"private", !"private"}
  %13 = load i64, ptr %left_index, align 8, !sec !{!"private", !"private"}
  %14 = load i64, ptr %key.addr, align 8, !sec !{!"private", !"private"}
  %15 = load ptr, ptr %right.addr, align 8, !sec !{!"private", !"private"}
  %call5 = call ptr @insert_into_node(ptr noundef %11, ptr noundef %12, i64 noundef %13, i64 noundef %14, ptr noundef %15), !sec !{!"call", !"private", !{!"private", !"private", !"private", !"private", !"private"}}
  store ptr %call5, ptr %retval, align 8, !sec !{!"private", !"private"}
  br label %return, !sec !{!"public"}

if.end6:                                          ; preds = %if.end, !sec !{!"private"}
  %16 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %17 = load ptr, ptr %parent, align 8, !sec !{!"private", !"private"}
  %18 = load i64, ptr %left_index, align 8, !sec !{!"private", !"private"}
  %19 = load i64, ptr %key.addr, align 8, !sec !{!"private", !"private"}
  %20 = load ptr, ptr %right.addr, align 8, !sec !{!"private", !"private"}
  %call7 = call ptr @insert_into_node_after_splitting(ptr noundef %16, ptr noundef %17, i64 noundef %18, i64 noundef %19, ptr noundef %20), !sec !{!"call", !"private", !{!"private", !"private", !"private", !"private", !"private"}}
  store ptr %call7, ptr %retval, align 8, !sec !{!"private", !"private"}
  br label %return, !sec !{!"public"}

return:                                           ; preds = %if.end6, %if.then4, %if.then, !sec !{!"private"}
  %21 = load ptr, ptr %retval, align 8, !sec !{!"private", !"private"}
  ret ptr %21, !sec !{!"private"}
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @insert_into_node(ptr noundef %root, ptr noundef %n, i64 noundef %left_index, i64 noundef %key, ptr noundef %right) #0 !sec !{!"private", !"private", !{!"private", !"private", !"private", !"private", !"private"}} {
entry:                                            ; !sec !{!"private"}
  %root.addr = alloca ptr, align 8, !sec !{!"private"}
  %n.addr = alloca ptr, align 8, !sec !{!"private"}
  %left_index.addr = alloca i64, align 8, !sec !{!"private"}
  %key.addr = alloca i64, align 8, !sec !{!"private"}
  %right.addr = alloca ptr, align 8, !sec !{!"private"}
  %i = alloca i64, align 8, !sec !{!"private"}
  store ptr %root, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  store ptr %n, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  store i64 %left_index, ptr %left_index.addr, align 8, !sec !{!"private", !"private"}
  store i64 %key, ptr %key.addr, align 8, !sec !{!"private", !"private"}
  store ptr %right, ptr %right.addr, align 8, !sec !{!"private", !"private"}
  %0 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %num_keys = getelementptr inbounds %struct.node, ptr %0, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %1 = load i64, ptr %num_keys, align 8, !sec !{!"private", !"private"}
  store i64 %1, ptr %i, align 8, !sec !{!"private", !"private"}
  br label %for.cond, !sec !{!"public"}

for.cond:                                         ; preds = %for.inc, %entry, !sec !{!"private"}
  %2 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %3 = load i64, ptr %left_index.addr, align 8, !sec !{!"private", !"private"}
  %cmp = icmp ugt i64 %2, %3, !sec !{!"private"}
  br i1 %cmp, label %for.body, label %for.end, !sec !{!"private"}

for.body:                                         ; preds = %for.cond, !sec !{!"private"}
  %4 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %pointers = getelementptr inbounds %struct.node, ptr %4, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %5 = load ptr, ptr %pointers, align 8, !sec !{!"private", !"private"}
  %6 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx = getelementptr inbounds ptr, ptr %5, i64 %6, !sec !{!"private", !"private", !"private"}
  %7 = load ptr, ptr %arrayidx, align 8, !sec !{!"private", !"private"}
  %8 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %pointers1 = getelementptr inbounds %struct.node, ptr %8, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %9 = load ptr, ptr %pointers1, align 8, !sec !{!"private", !"private"}
  %10 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %add = add i64 %10, 1, !sec !{!"private"}
  %arrayidx2 = getelementptr inbounds ptr, ptr %9, i64 %add, !sec !{!"private", !"private", !"private"}
  store ptr %7, ptr %arrayidx2, align 8, !sec !{!"private", !"private"}
  %11 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %keys = getelementptr inbounds %struct.node, ptr %11, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %12 = load ptr, ptr %keys, align 8, !sec !{!"private", !"private"}
  %13 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %sub = sub i64 %13, 1, !sec !{!"private"}
  %arrayidx3 = getelementptr inbounds i64, ptr %12, i64 %sub, !sec !{!"private", !"private", !"private"}
  %14 = load i64, ptr %arrayidx3, align 8, !sec !{!"private", !"private"}
  %15 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %keys4 = getelementptr inbounds %struct.node, ptr %15, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %16 = load ptr, ptr %keys4, align 8, !sec !{!"private", !"private"}
  %17 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx5 = getelementptr inbounds i64, ptr %16, i64 %17, !sec !{!"private", !"private", !"private"}
  store i64 %14, ptr %arrayidx5, align 8, !sec !{!"private", !"private"}
  br label %for.inc, !sec !{!"public"}

for.inc:                                          ; preds = %for.body, !sec !{!"private"}
  %18 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %dec = add i64 %18, -1, !sec !{!"private"}
  store i64 %dec, ptr %i, align 8, !sec !{!"private", !"private"}
  br label %for.cond, !llvm.loop !33, !sec !{!"public"}

for.end:                                          ; preds = %for.cond, !sec !{!"private"}
  %19 = load ptr, ptr %right.addr, align 8, !sec !{!"private", !"private"}
  %20 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %pointers6 = getelementptr inbounds %struct.node, ptr %20, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %21 = load ptr, ptr %pointers6, align 8, !sec !{!"private", !"private"}
  %22 = load i64, ptr %left_index.addr, align 8, !sec !{!"private", !"private"}
  %add7 = add i64 %22, 1, !sec !{!"private"}
  %arrayidx8 = getelementptr inbounds ptr, ptr %21, i64 %add7, !sec !{!"private", !"private", !"private"}
  store ptr %19, ptr %arrayidx8, align 8, !sec !{!"private", !"private"}
  %23 = load i64, ptr %key.addr, align 8, !sec !{!"private", !"private"}
  %24 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %keys9 = getelementptr inbounds %struct.node, ptr %24, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %25 = load ptr, ptr %keys9, align 8, !sec !{!"private", !"private"}
  %26 = load i64, ptr %left_index.addr, align 8, !sec !{!"private", !"private"}
  %arrayidx10 = getelementptr inbounds i64, ptr %25, i64 %26, !sec !{!"private", !"private", !"private"}
  store i64 %23, ptr %arrayidx10, align 8, !sec !{!"private", !"private"}
  %27 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %num_keys11 = getelementptr inbounds %struct.node, ptr %27, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %28 = load i64, ptr %num_keys11, align 8, !sec !{!"private", !"private"}
  %inc = add i64 %28, 1, !sec !{!"private"}
  store i64 %inc, ptr %num_keys11, align 8, !sec !{!"private", !"private"}
  %29 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  ret ptr %29, !sec !{!"private"}
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @insert_into_node_after_splitting(ptr noundef %root, ptr noundef %old_node, i64 noundef %left_index, i64 noundef %key, ptr noundef %right) #0 !sec !{!"private", !"private", !{!"private", !"private", !"private", !"private", !"private"}} {
entry:                                            ; !sec !{!"private"}
  %root.addr = alloca ptr, align 8, !sec !{!"private"}
  %old_node.addr = alloca ptr, align 8, !sec !{!"private"}
  %left_index.addr = alloca i64, align 8, !sec !{!"private"}
  %key.addr = alloca i64, align 8, !sec !{!"private"}
  %right.addr = alloca ptr, align 8, !sec !{!"private"}
  %i = alloca i64, align 8, !sec !{!"private"}
  %j = alloca i64, align 8, !sec !{!"private"}
  %split = alloca i64, align 8, !sec !{!"private"}
  %k_prime = alloca i64, align 8, !sec !{!"private"}
  %new_node = alloca ptr, align 8, !sec !{!"private"}
  %child = alloca ptr, align 8, !sec !{!"private"}
  %temp_keys = alloca ptr, align 8, !sec !{!"private"}
  %temp_pointers = alloca ptr, align 8, !sec !{!"private"}
  store ptr %root, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  store ptr %old_node, ptr %old_node.addr, align 8, !sec !{!"private", !"private"}
  store i64 %left_index, ptr %left_index.addr, align 8, !sec !{!"private", !"private"}
  store i64 %key, ptr %key.addr, align 8, !sec !{!"private", !"private"}
  store ptr %right, ptr %right.addr, align 8, !sec !{!"private", !"private"}
  %0 = load i64, ptr @order, align 8, !sec !{!"private", !"private"}
  %add = add i64 %0, 1, !sec !{!"private"}
  %mul = mul i64 %add, 8, !sec !{!"private"}
  %call = call ptr @allocate_align64(i64 noundef %mul), !sec !{!"call", !"private", !{!"private"}}
  store ptr %call, ptr %temp_pointers, align 8, !sec !{!"private", !"private"}
  %1 = load ptr, ptr %temp_pointers, align 8, !sec !{!"private", !"private"}
  %cmp = icmp eq ptr %1, null, !sec !{!"private"}
  br i1 %cmp, label %if.then, label %if.end, !sec !{!"private"}

if.then:                                          ; preds = %entry, !sec !{!"private"}
  call void @exit(i32 noundef 1) #7, !sec !{!"call", !"void", !{!"public"}}
  unreachable

if.end:                                           ; preds = %entry, %if.then, !sec !{!"private"}
  %2 = load i64, ptr @order, align 8, !sec !{!"private", !"private"}
  %mul1 = mul i64 %2, 8, !sec !{!"private"}
  %call2 = call ptr @allocate_align64(i64 noundef %mul1), !sec !{!"call", !"private", !{!"private"}}
  store ptr %call2, ptr %temp_keys, align 8, !sec !{!"private", !"private"}
  %3 = load ptr, ptr %temp_keys, align 8, !sec !{!"private", !"private"}
  %cmp3 = icmp eq ptr %3, null, !sec !{!"private"}
  br i1 %cmp3, label %if.then4, label %if.end5, !sec !{!"private"}

if.then4:                                         ; preds = %if.end, !sec !{!"private"}
  call void @exit(i32 noundef 1) #7, !sec !{!"call", !"void", !{!"public"}}
  unreachable

if.end5:                                          ; preds = %if.end, %if.then4, !sec !{!"private"}
  store i64 0, ptr %i, align 8, !sec !{!"public", !"private"}
  store i64 0, ptr %j, align 8, !sec !{!"public", !"private"}
  br label %for.cond, !sec !{!"public"}

for.cond:                                         ; preds = %for.inc, %if.end5, !sec !{!"private"}
  %4 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %5 = load ptr, ptr %old_node.addr, align 8, !sec !{!"private", !"private"}
  %num_keys = getelementptr inbounds %struct.node, ptr %5, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %6 = load i64, ptr %num_keys, align 8, !sec !{!"private", !"private"}
  %add6 = add i64 %6, 1, !sec !{!"private"}
  %cmp7 = icmp ult i64 %4, %add6, !sec !{!"private"}
  br i1 %cmp7, label %for.body, label %for.end, !sec !{!"private"}

for.body:                                         ; preds = %for.cond, !sec !{!"private"}
  %7 = load i64, ptr %j, align 8, !sec !{!"private", !"private"}
  %8 = load i64, ptr %left_index.addr, align 8, !sec !{!"private", !"private"}
  %add8 = add i64 %8, 1, !sec !{!"private"}
  %cmp9 = icmp eq i64 %7, %add8, !sec !{!"private"}
  br i1 %cmp9, label %if.then10, label %if.end11, !sec !{!"private"}

if.then10:                                        ; preds = %for.body, !sec !{!"private"}
  %9 = load i64, ptr %j, align 8, !sec !{!"private", !"private"}
  %inc = add i64 %9, 1, !sec !{!"private"}
  store i64 %inc, ptr %j, align 8, !sec !{!"private", !"private"}
  br label %if.end11, !sec !{!"public"}

if.end11:                                         ; preds = %if.then10, %for.body, !sec !{!"private"}
  %10 = load ptr, ptr %old_node.addr, align 8, !sec !{!"private", !"private"}
  %pointers = getelementptr inbounds %struct.node, ptr %10, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %11 = load ptr, ptr %pointers, align 8, !sec !{!"private", !"private"}
  %12 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx = getelementptr inbounds ptr, ptr %11, i64 %12, !sec !{!"private", !"private", !"private"}
  %13 = load ptr, ptr %arrayidx, align 8, !sec !{!"private", !"private"}
  %14 = load ptr, ptr %temp_pointers, align 8, !sec !{!"private", !"private"}
  %15 = load i64, ptr %j, align 8, !sec !{!"private", !"private"}
  %arrayidx12 = getelementptr inbounds ptr, ptr %14, i64 %15, !sec !{!"private", !"private", !"private"}
  store ptr %13, ptr %arrayidx12, align 8, !sec !{!"private", !"private"}
  br label %for.inc, !sec !{!"public"}

for.inc:                                          ; preds = %if.end11, !sec !{!"private"}
  %16 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %inc13 = add i64 %16, 1, !sec !{!"private"}
  store i64 %inc13, ptr %i, align 8, !sec !{!"private", !"private"}
  %17 = load i64, ptr %j, align 8, !sec !{!"private", !"private"}
  %inc14 = add i64 %17, 1, !sec !{!"private"}
  store i64 %inc14, ptr %j, align 8, !sec !{!"private", !"private"}
  br label %for.cond, !llvm.loop !34, !sec !{!"public"}

for.end:                                          ; preds = %for.cond, !sec !{!"private"}
  store i64 0, ptr %i, align 8, !sec !{!"public", !"private"}
  store i64 0, ptr %j, align 8, !sec !{!"public", !"private"}
  br label %for.cond15, !sec !{!"public"}

for.cond15:                                       ; preds = %for.inc25, %for.end, !sec !{!"private"}
  %18 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %19 = load ptr, ptr %old_node.addr, align 8, !sec !{!"private", !"private"}
  %num_keys16 = getelementptr inbounds %struct.node, ptr %19, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %20 = load i64, ptr %num_keys16, align 8, !sec !{!"private", !"private"}
  %cmp17 = icmp ult i64 %18, %20, !sec !{!"private"}
  br i1 %cmp17, label %for.body18, label %for.end28, !sec !{!"private"}

for.body18:                                       ; preds = %for.cond15, !sec !{!"private"}
  %21 = load i64, ptr %j, align 8, !sec !{!"private", !"private"}
  %22 = load i64, ptr %left_index.addr, align 8, !sec !{!"private", !"private"}
  %cmp19 = icmp eq i64 %21, %22, !sec !{!"private"}
  br i1 %cmp19, label %if.then20, label %if.end22, !sec !{!"private"}

if.then20:                                        ; preds = %for.body18, !sec !{!"private"}
  %23 = load i64, ptr %j, align 8, !sec !{!"private", !"private"}
  %inc21 = add i64 %23, 1, !sec !{!"private"}
  store i64 %inc21, ptr %j, align 8, !sec !{!"private", !"private"}
  br label %if.end22, !sec !{!"public"}

if.end22:                                         ; preds = %if.then20, %for.body18, !sec !{!"private"}
  %24 = load ptr, ptr %old_node.addr, align 8, !sec !{!"private", !"private"}
  %keys = getelementptr inbounds %struct.node, ptr %24, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %25 = load ptr, ptr %keys, align 8, !sec !{!"private", !"private"}
  %26 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx23 = getelementptr inbounds i64, ptr %25, i64 %26, !sec !{!"private", !"private", !"private"}
  %27 = load i64, ptr %arrayidx23, align 8, !sec !{!"private", !"private"}
  %28 = load ptr, ptr %temp_keys, align 8, !sec !{!"private", !"private"}
  %29 = load i64, ptr %j, align 8, !sec !{!"private", !"private"}
  %arrayidx24 = getelementptr inbounds i64, ptr %28, i64 %29, !sec !{!"private", !"private", !"private"}
  store i64 %27, ptr %arrayidx24, align 8, !sec !{!"private", !"private"}
  br label %for.inc25, !sec !{!"public"}

for.inc25:                                        ; preds = %if.end22, !sec !{!"private"}
  %30 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %inc26 = add i64 %30, 1, !sec !{!"private"}
  store i64 %inc26, ptr %i, align 8, !sec !{!"private", !"private"}
  %31 = load i64, ptr %j, align 8, !sec !{!"private", !"private"}
  %inc27 = add i64 %31, 1, !sec !{!"private"}
  store i64 %inc27, ptr %j, align 8, !sec !{!"private", !"private"}
  br label %for.cond15, !llvm.loop !35, !sec !{!"public"}

for.end28:                                        ; preds = %for.cond15, !sec !{!"private"}
  %32 = load ptr, ptr %right.addr, align 8, !sec !{!"private", !"private"}
  %33 = load ptr, ptr %temp_pointers, align 8, !sec !{!"private", !"private"}
  %34 = load i64, ptr %left_index.addr, align 8, !sec !{!"private", !"private"}
  %add29 = add i64 %34, 1, !sec !{!"private"}
  %arrayidx30 = getelementptr inbounds ptr, ptr %33, i64 %add29, !sec !{!"private", !"private", !"private"}
  store ptr %32, ptr %arrayidx30, align 8, !sec !{!"private", !"private"}
  %35 = load i64, ptr %key.addr, align 8, !sec !{!"private", !"private"}
  %36 = load ptr, ptr %temp_keys, align 8, !sec !{!"private", !"private"}
  %37 = load i64, ptr %left_index.addr, align 8, !sec !{!"private", !"private"}
  %arrayidx31 = getelementptr inbounds i64, ptr %36, i64 %37, !sec !{!"private", !"private", !"private"}
  store i64 %35, ptr %arrayidx31, align 8, !sec !{!"private", !"private"}
  %38 = load i64, ptr @order, align 8, !sec !{!"private", !"private"}
  %call32 = call i64 @cut(i64 noundef %38), !sec !{!"call", !"private", !{!"private"}}
  store i64 %call32, ptr %split, align 8, !sec !{!"private", !"private"}
  %call33 = call ptr @make_node(), !sec !{!"call", !"private", !{}}
  store ptr %call33, ptr %new_node, align 8, !sec !{!"private", !"private"}
  %39 = load ptr, ptr %old_node.addr, align 8, !sec !{!"private", !"private"}
  %num_keys34 = getelementptr inbounds %struct.node, ptr %39, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  store i64 0, ptr %num_keys34, align 8, !sec !{!"public", !"private"}
  store i64 0, ptr %i, align 8, !sec !{!"public", !"private"}
  br label %for.cond35, !sec !{!"public"}

for.cond35:                                       ; preds = %for.inc46, %for.end28, !sec !{!"private"}
  %40 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %41 = load i64, ptr %split, align 8, !sec !{!"private", !"private"}
  %sub = sub i64 %41, 1, !sec !{!"private"}
  %cmp36 = icmp ult i64 %40, %sub, !sec !{!"private"}
  br i1 %cmp36, label %for.body37, label %for.end48, !sec !{!"private"}

for.body37:                                       ; preds = %for.cond35, !sec !{!"private"}
  %42 = load ptr, ptr %temp_pointers, align 8, !sec !{!"private", !"private"}
  %43 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx38 = getelementptr inbounds ptr, ptr %42, i64 %43, !sec !{!"private", !"private", !"private"}
  %44 = load ptr, ptr %arrayidx38, align 8, !sec !{!"private", !"private"}
  %45 = load ptr, ptr %old_node.addr, align 8, !sec !{!"private", !"private"}
  %pointers39 = getelementptr inbounds %struct.node, ptr %45, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %46 = load ptr, ptr %pointers39, align 8, !sec !{!"private", !"private"}
  %47 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx40 = getelementptr inbounds ptr, ptr %46, i64 %47, !sec !{!"private", !"private", !"private"}
  store ptr %44, ptr %arrayidx40, align 8, !sec !{!"private", !"private"}
  %48 = load ptr, ptr %temp_keys, align 8, !sec !{!"private", !"private"}
  %49 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx41 = getelementptr inbounds i64, ptr %48, i64 %49, !sec !{!"private", !"private", !"private"}
  %50 = load i64, ptr %arrayidx41, align 8, !sec !{!"private", !"private"}
  %51 = load ptr, ptr %old_node.addr, align 8, !sec !{!"private", !"private"}
  %keys42 = getelementptr inbounds %struct.node, ptr %51, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %52 = load ptr, ptr %keys42, align 8, !sec !{!"private", !"private"}
  %53 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx43 = getelementptr inbounds i64, ptr %52, i64 %53, !sec !{!"private", !"private", !"private"}
  store i64 %50, ptr %arrayidx43, align 8, !sec !{!"private", !"private"}
  %54 = load ptr, ptr %old_node.addr, align 8, !sec !{!"private", !"private"}
  %num_keys44 = getelementptr inbounds %struct.node, ptr %54, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %55 = load i64, ptr %num_keys44, align 8, !sec !{!"private", !"private"}
  %inc45 = add i64 %55, 1, !sec !{!"private"}
  store i64 %inc45, ptr %num_keys44, align 8, !sec !{!"private", !"private"}
  br label %for.inc46, !sec !{!"public"}

for.inc46:                                        ; preds = %for.body37, !sec !{!"private"}
  %56 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %inc47 = add i64 %56, 1, !sec !{!"private"}
  store i64 %inc47, ptr %i, align 8, !sec !{!"private", !"private"}
  br label %for.cond35, !llvm.loop !36, !sec !{!"public"}

for.end48:                                        ; preds = %for.cond35, !sec !{!"private"}
  %57 = load ptr, ptr %temp_pointers, align 8, !sec !{!"private", !"private"}
  %58 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx49 = getelementptr inbounds ptr, ptr %57, i64 %58, !sec !{!"private", !"private", !"private"}
  %59 = load ptr, ptr %arrayidx49, align 8, !sec !{!"private", !"private"}
  %60 = load ptr, ptr %old_node.addr, align 8, !sec !{!"private", !"private"}
  %pointers50 = getelementptr inbounds %struct.node, ptr %60, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %61 = load ptr, ptr %pointers50, align 8, !sec !{!"private", !"private"}
  %62 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx51 = getelementptr inbounds ptr, ptr %61, i64 %62, !sec !{!"private", !"private", !"private"}
  store ptr %59, ptr %arrayidx51, align 8, !sec !{!"private", !"private"}
  %63 = load ptr, ptr %temp_keys, align 8, !sec !{!"private", !"private"}
  %64 = load i64, ptr %split, align 8, !sec !{!"private", !"private"}
  %sub52 = sub i64 %64, 1, !sec !{!"private"}
  %arrayidx53 = getelementptr inbounds i64, ptr %63, i64 %sub52, !sec !{!"private", !"private", !"private"}
  %65 = load i64, ptr %arrayidx53, align 8, !sec !{!"private", !"private"}
  store i64 %65, ptr %k_prime, align 8, !sec !{!"private", !"private"}
  %66 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %inc54 = add i64 %66, 1, !sec !{!"private"}
  store i64 %inc54, ptr %i, align 8, !sec !{!"private", !"private"}
  store i64 0, ptr %j, align 8, !sec !{!"public", !"private"}
  br label %for.cond55, !sec !{!"public"}

for.cond55:                                       ; preds = %for.inc66, %for.end48, !sec !{!"private"}
  %67 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %68 = load i64, ptr @order, align 8, !sec !{!"private", !"private"}
  %cmp56 = icmp ult i64 %67, %68, !sec !{!"private"}
  br i1 %cmp56, label %for.body57, label %for.end69, !sec !{!"private"}

for.body57:                                       ; preds = %for.cond55, !sec !{!"private"}
  %69 = load ptr, ptr %temp_pointers, align 8, !sec !{!"private", !"private"}
  %70 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx58 = getelementptr inbounds ptr, ptr %69, i64 %70, !sec !{!"private", !"private", !"private"}
  %71 = load ptr, ptr %arrayidx58, align 8, !sec !{!"private", !"private"}
  %72 = load ptr, ptr %new_node, align 8, !sec !{!"private", !"private"}
  %pointers59 = getelementptr inbounds %struct.node, ptr %72, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %73 = load ptr, ptr %pointers59, align 8, !sec !{!"private", !"private"}
  %74 = load i64, ptr %j, align 8, !sec !{!"private", !"private"}
  %arrayidx60 = getelementptr inbounds ptr, ptr %73, i64 %74, !sec !{!"private", !"private", !"private"}
  store ptr %71, ptr %arrayidx60, align 8, !sec !{!"private", !"private"}
  %75 = load ptr, ptr %temp_keys, align 8, !sec !{!"private", !"private"}
  %76 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx61 = getelementptr inbounds i64, ptr %75, i64 %76, !sec !{!"private", !"private", !"private"}
  %77 = load i64, ptr %arrayidx61, align 8, !sec !{!"private", !"private"}
  %78 = load ptr, ptr %new_node, align 8, !sec !{!"private", !"private"}
  %keys62 = getelementptr inbounds %struct.node, ptr %78, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %79 = load ptr, ptr %keys62, align 8, !sec !{!"private", !"private"}
  %80 = load i64, ptr %j, align 8, !sec !{!"private", !"private"}
  %arrayidx63 = getelementptr inbounds i64, ptr %79, i64 %80, !sec !{!"private", !"private", !"private"}
  store i64 %77, ptr %arrayidx63, align 8, !sec !{!"private", !"private"}
  %81 = load ptr, ptr %new_node, align 8, !sec !{!"private", !"private"}
  %num_keys64 = getelementptr inbounds %struct.node, ptr %81, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %82 = load i64, ptr %num_keys64, align 8, !sec !{!"private", !"private"}
  %inc65 = add i64 %82, 1, !sec !{!"private"}
  store i64 %inc65, ptr %num_keys64, align 8, !sec !{!"private", !"private"}
  br label %for.inc66, !sec !{!"public"}

for.inc66:                                        ; preds = %for.body57, !sec !{!"private"}
  %83 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %inc67 = add i64 %83, 1, !sec !{!"private"}
  store i64 %inc67, ptr %i, align 8, !sec !{!"private", !"private"}
  %84 = load i64, ptr %j, align 8, !sec !{!"private", !"private"}
  %inc68 = add i64 %84, 1, !sec !{!"private"}
  store i64 %inc68, ptr %j, align 8, !sec !{!"private", !"private"}
  br label %for.cond55, !llvm.loop !37, !sec !{!"public"}

for.end69:                                        ; preds = %for.cond55, !sec !{!"private"}
  %85 = load ptr, ptr %temp_pointers, align 8, !sec !{!"private", !"private"}
  %86 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx70 = getelementptr inbounds ptr, ptr %85, i64 %86, !sec !{!"private", !"private", !"private"}
  %87 = load ptr, ptr %arrayidx70, align 8, !sec !{!"private", !"private"}
  %88 = load ptr, ptr %new_node, align 8, !sec !{!"private", !"private"}
  %pointers71 = getelementptr inbounds %struct.node, ptr %88, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %89 = load ptr, ptr %pointers71, align 8, !sec !{!"private", !"private"}
  %90 = load i64, ptr %j, align 8, !sec !{!"private", !"private"}
  %arrayidx72 = getelementptr inbounds ptr, ptr %89, i64 %90, !sec !{!"private", !"private", !"private"}
  store ptr %87, ptr %arrayidx72, align 8, !sec !{!"private", !"private"}
  %91 = load ptr, ptr %temp_pointers, align 8, !sec !{!"private", !"private"}
  call void @free(ptr noundef %91) #8, !sec !{!"public"}
  %92 = load ptr, ptr %temp_keys, align 8, !sec !{!"private", !"private"}
  call void @free(ptr noundef %92) #8, !sec !{!"public"}
  %93 = load ptr, ptr %old_node.addr, align 8, !sec !{!"private", !"private"}
  %parent = getelementptr inbounds %struct.node, ptr %93, i32 0, i32 2, !sec !{!"private", !"private", !"public", !"public"}
  %94 = load ptr, ptr %parent, align 8, !sec !{!"private", !"private"}
  %95 = load ptr, ptr %new_node, align 8, !sec !{!"private", !"private"}
  %parent73 = getelementptr inbounds %struct.node, ptr %95, i32 0, i32 2, !sec !{!"private", !"private", !"public", !"public"}
  store ptr %94, ptr %parent73, align 8, !sec !{!"private", !"private"}
  store i64 0, ptr %i, align 8, !sec !{!"public", !"private"}
  br label %for.cond74, !sec !{!"public"}

for.cond74:                                       ; preds = %for.inc81, %for.end69, !sec !{!"private"}
  %96 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %97 = load ptr, ptr %new_node, align 8, !sec !{!"private", !"private"}
  %num_keys75 = getelementptr inbounds %struct.node, ptr %97, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %98 = load i64, ptr %num_keys75, align 8, !sec !{!"private", !"private"}
  %cmp76 = icmp ule i64 %96, %98, !sec !{!"private"}
  br i1 %cmp76, label %for.body77, label %for.end83, !sec !{!"private"}

for.body77:                                       ; preds = %for.cond74, !sec !{!"private"}
  %99 = load ptr, ptr %new_node, align 8, !sec !{!"private", !"private"}
  %pointers78 = getelementptr inbounds %struct.node, ptr %99, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %100 = load ptr, ptr %pointers78, align 8, !sec !{!"private", !"private"}
  %101 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx79 = getelementptr inbounds ptr, ptr %100, i64 %101, !sec !{!"private", !"private", !"private"}
  %102 = load ptr, ptr %arrayidx79, align 8, !sec !{!"private", !"private"}
  store ptr %102, ptr %child, align 8, !sec !{!"private", !"private"}
  %103 = load ptr, ptr %new_node, align 8, !sec !{!"private", !"private"}
  %104 = load ptr, ptr %child, align 8, !sec !{!"private", !"private"}
  %parent80 = getelementptr inbounds %struct.node, ptr %104, i32 0, i32 2, !sec !{!"private", !"private", !"public", !"public"}
  store ptr %103, ptr %parent80, align 8, !sec !{!"private", !"private"}
  br label %for.inc81, !sec !{!"public"}

for.inc81:                                        ; preds = %for.body77, !sec !{!"private"}
  %105 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %inc82 = add i64 %105, 1, !sec !{!"private"}
  store i64 %inc82, ptr %i, align 8, !sec !{!"private", !"private"}
  br label %for.cond74, !llvm.loop !38, !sec !{!"public"}

for.end83:                                        ; preds = %for.cond74, !sec !{!"private"}
  %106 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %107 = load ptr, ptr %old_node.addr, align 8, !sec !{!"private", !"private"}
  %108 = load i64, ptr %k_prime, align 8, !sec !{!"private", !"private"}
  %109 = load ptr, ptr %new_node, align 8, !sec !{!"private", !"private"}
  %call84 = call ptr @insert_into_parent(ptr noundef %106, ptr noundef %107, i64 noundef %108, ptr noundef %109), !sec !{!"call", !"private", !{!"private", !"private", !"private", !"private"}}
  ret ptr %call84, !sec !{!"private"}
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @insert_into_new_root(ptr noundef %left, i64 noundef %key, ptr noundef %right) #0 !sec !{!"private", !"private", !{!"private", !"private", !"private"}} {
entry:                                            ; !sec !{!"private"}
  %left.addr = alloca ptr, align 8, !sec !{!"private"}
  %key.addr = alloca i64, align 8, !sec !{!"private"}
  %right.addr = alloca ptr, align 8, !sec !{!"private"}
  %root = alloca ptr, align 8, !sec !{!"private"}
  store ptr %left, ptr %left.addr, align 8, !sec !{!"private", !"private"}
  store i64 %key, ptr %key.addr, align 8, !sec !{!"private", !"private"}
  store ptr %right, ptr %right.addr, align 8, !sec !{!"private", !"private"}
  %call = call ptr @make_node(), !sec !{!"call", !"private", !{}}
  store ptr %call, ptr %root, align 8, !sec !{!"private", !"private"}
  %0 = load i64, ptr %key.addr, align 8, !sec !{!"private", !"private"}
  %1 = load ptr, ptr %root, align 8, !sec !{!"private", !"private"}
  %keys = getelementptr inbounds %struct.node, ptr %1, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %2 = load ptr, ptr %keys, align 8, !sec !{!"private", !"private"}
  %arrayidx = getelementptr inbounds i64, ptr %2, i64 0, !sec !{!"private", !"private", !"public"}
  store i64 %0, ptr %arrayidx, align 8, !sec !{!"private", !"private"}
  %3 = load ptr, ptr %left.addr, align 8, !sec !{!"private", !"private"}
  %4 = load ptr, ptr %root, align 8, !sec !{!"private", !"private"}
  %pointers = getelementptr inbounds %struct.node, ptr %4, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %5 = load ptr, ptr %pointers, align 8, !sec !{!"private", !"private"}
  %arrayidx1 = getelementptr inbounds ptr, ptr %5, i64 0, !sec !{!"private", !"private", !"public"}
  store ptr %3, ptr %arrayidx1, align 8, !sec !{!"private", !"private"}
  %6 = load ptr, ptr %right.addr, align 8, !sec !{!"private", !"private"}
  %7 = load ptr, ptr %root, align 8, !sec !{!"private", !"private"}
  %pointers2 = getelementptr inbounds %struct.node, ptr %7, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %8 = load ptr, ptr %pointers2, align 8, !sec !{!"private", !"private"}
  %arrayidx3 = getelementptr inbounds ptr, ptr %8, i64 1, !sec !{!"private", !"private", !"public"}
  store ptr %6, ptr %arrayidx3, align 8, !sec !{!"private", !"private"}
  %9 = load ptr, ptr %root, align 8, !sec !{!"private", !"private"}
  %num_keys = getelementptr inbounds %struct.node, ptr %9, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %10 = load i64, ptr %num_keys, align 8, !sec !{!"private", !"private"}
  %inc = add i64 %10, 1, !sec !{!"private"}
  store i64 %inc, ptr %num_keys, align 8, !sec !{!"private", !"private"}
  %11 = load ptr, ptr %root, align 8, !sec !{!"private", !"private"}
  %parent = getelementptr inbounds %struct.node, ptr %11, i32 0, i32 2, !sec !{!"private", !"private", !"public", !"public"}
  store ptr null, ptr %parent, align 8, !sec !{!"public", !"private"}
  %12 = load ptr, ptr %root, align 8, !sec !{!"private", !"private"}
  %13 = load ptr, ptr %left.addr, align 8, !sec !{!"private", !"private"}
  %parent4 = getelementptr inbounds %struct.node, ptr %13, i32 0, i32 2, !sec !{!"private", !"private", !"public", !"public"}
  store ptr %12, ptr %parent4, align 8, !sec !{!"private", !"private"}
  %14 = load ptr, ptr %root, align 8, !sec !{!"private", !"private"}
  %15 = load ptr, ptr %right.addr, align 8, !sec !{!"private", !"private"}
  %parent5 = getelementptr inbounds %struct.node, ptr %15, i32 0, i32 2, !sec !{!"private", !"private", !"public", !"public"}
  store ptr %14, ptr %parent5, align 8, !sec !{!"private", !"private"}
  %16 = load ptr, ptr %root, align 8, !sec !{!"private", !"private"}
  ret ptr %16, !sec !{!"private"}
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @start_new_tree(i64 noundef %key, ptr noundef %pointer) #0 !sec !{!"private", !"private", !{!"private", !"private"}} {
entry:                                            ; !sec !{!"private"}
  %key.addr = alloca i64, align 8, !sec !{!"private"}
  %pointer.addr = alloca ptr, align 8, !sec !{!"private"}
  %root = alloca ptr, align 8, !sec !{!"private"}
  store i64 %key, ptr %key.addr, align 8, !sec !{!"private", !"private"}
  store ptr %pointer, ptr %pointer.addr, align 8, !sec !{!"private", !"private"}
  %call = call ptr @make_leaf(), !sec !{!"call", !"private", !{}}
  store ptr %call, ptr %root, align 8, !sec !{!"private", !"private"}
  %0 = load i64, ptr %key.addr, align 8, !sec !{!"private", !"private"}
  %1 = load ptr, ptr %root, align 8, !sec !{!"private", !"private"}
  %keys = getelementptr inbounds %struct.node, ptr %1, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %2 = load ptr, ptr %keys, align 8, !sec !{!"private", !"private"}
  %arrayidx = getelementptr inbounds i64, ptr %2, i64 0, !sec !{!"private", !"private", !"public"}
  store i64 %0, ptr %arrayidx, align 8, !sec !{!"private", !"private"}
  %3 = load ptr, ptr %pointer.addr, align 8, !sec !{!"private", !"private"}
  %4 = load ptr, ptr %root, align 8, !sec !{!"private", !"private"}
  %pointers = getelementptr inbounds %struct.node, ptr %4, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %5 = load ptr, ptr %pointers, align 8, !sec !{!"private", !"private"}
  %arrayidx1 = getelementptr inbounds ptr, ptr %5, i64 0, !sec !{!"private", !"private", !"public"}
  store ptr %3, ptr %arrayidx1, align 8, !sec !{!"private", !"private"}
  %6 = load ptr, ptr %root, align 8, !sec !{!"private", !"private"}
  %pointers2 = getelementptr inbounds %struct.node, ptr %6, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %7 = load ptr, ptr %pointers2, align 8, !sec !{!"private", !"private"}
  %8 = load i64, ptr @order, align 8, !sec !{!"private", !"private"}
  %sub = sub i64 %8, 1, !sec !{!"private"}
  %arrayidx3 = getelementptr inbounds ptr, ptr %7, i64 %sub, !sec !{!"private", !"private", !"private"}
  store ptr null, ptr %arrayidx3, align 8, !sec !{!"public", !"private"}
  %9 = load ptr, ptr %root, align 8, !sec !{!"private", !"private"}
  %parent = getelementptr inbounds %struct.node, ptr %9, i32 0, i32 2, !sec !{!"private", !"private", !"public", !"public"}
  store ptr null, ptr %parent, align 8, !sec !{!"public", !"private"}
  %10 = load ptr, ptr %root, align 8, !sec !{!"private", !"private"}
  %num_keys = getelementptr inbounds %struct.node, ptr %10, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %11 = load i64, ptr %num_keys, align 8, !sec !{!"private", !"private"}
  %inc = add i64 %11, 1, !sec !{!"private"}
  store i64 %inc, ptr %num_keys, align 8, !sec !{!"private", !"private"}
  %12 = load ptr, ptr %root, align 8, !sec !{!"private", !"private"}
  ret ptr %12, !sec !{!"private"}
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @insert(ptr noundef %root, i64 noundef %key, i64 noundef %value) #0 !sec !{!"private", !"private", !{!"private", !"private", !"private"}} {
entry:                                            ; !sec !{!"private"}
  %retval = alloca ptr, align 8, !sec !{!"private"}
  %root.addr = alloca ptr, align 8, !sec !{!"private"}
  %key.addr = alloca i64, align 8, !sec !{!"private"}
  %value.addr = alloca i64, align 8, !sec !{!"private"}
  %record_pointer = alloca ptr, align 8, !sec !{!"private"}
  %leaf = alloca ptr, align 8, !sec !{!"private"}
  store ptr %root, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  store i64 %key, ptr %key.addr, align 8, !sec !{!"private", !"private"}
  store i64 %value, ptr %value.addr, align 8, !sec !{!"private", !"private"}
  store ptr null, ptr %record_pointer, align 8, !sec !{!"public", !"private"}
  store ptr null, ptr %leaf, align 8, !sec !{!"public", !"private"}
  %0 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %1 = load i64, ptr %key.addr, align 8, !sec !{!"private", !"private"}
  %call = call ptr @find(ptr noundef %0, i64 noundef %1, ptr noundef null), !sec !{!"call", !"private", !{!"private", !"private", !"private"}}
  store ptr %call, ptr %record_pointer, align 8, !sec !{!"private", !"private"}
  %2 = load ptr, ptr %record_pointer, align 8, !sec !{!"private", !"private"}
  %cmp = icmp ne ptr %2, null, !sec !{!"private"}
  br i1 %cmp, label %if.then, label %if.end, !sec !{!"private"}

if.then:                                          ; preds = %entry, !sec !{!"private"}
  %3 = load i64, ptr %value.addr, align 8, !sec !{!"private", !"private"}
  %4 = load ptr, ptr %record_pointer, align 8, !sec !{!"private", !"private"}
  %value1 = getelementptr inbounds %struct.record, ptr %4, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  store i64 %3, ptr %value1, align 8, !sec !{!"private", !"private"}
  %5 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  store ptr %5, ptr %retval, align 8, !sec !{!"private", !"private"}
  br label %return, !sec !{!"public"}

if.end:                                           ; preds = %entry, !sec !{!"private"}
  %6 = load i64, ptr %value.addr, align 8, !sec !{!"private", !"private"}
  %call2 = call ptr @make_record(i64 noundef %6), !sec !{!"call", !"private", !{!"private"}}
  store ptr %call2, ptr %record_pointer, align 8, !sec !{!"private", !"private"}
  %7 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %cmp3 = icmp eq ptr %7, null, !sec !{!"private"}
  br i1 %cmp3, label %if.then4, label %if.end6, !sec !{!"private"}

if.then4:                                         ; preds = %if.end, !sec !{!"private"}
  %8 = load i64, ptr %key.addr, align 8, !sec !{!"private", !"private"}
  %9 = load ptr, ptr %record_pointer, align 8, !sec !{!"private", !"private"}
  %call5 = call ptr @start_new_tree(i64 noundef %8, ptr noundef %9), !sec !{!"call", !"private", !{!"private", !"private"}}
  store ptr %call5, ptr %retval, align 8, !sec !{!"private", !"private"}
  br label %return, !sec !{!"public"}

if.end6:                                          ; preds = %if.end, !sec !{!"private"}
  %10 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %11 = load i64, ptr %key.addr, align 8, !sec !{!"private", !"private"}
  %call7 = call ptr @find_leaf(ptr noundef %10, i64 noundef %11), !sec !{!"call", !"private", !{!"private", !"private"}}
  store ptr %call7, ptr %leaf, align 8, !sec !{!"private", !"private"}
  %12 = load ptr, ptr %leaf, align 8, !sec !{!"private", !"private"}
  %num_keys = getelementptr inbounds %struct.node, ptr %12, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %13 = load i64, ptr %num_keys, align 8, !sec !{!"private", !"private"}
  %14 = load i64, ptr @order, align 8, !sec !{!"private", !"private"}
  %sub = sub i64 %14, 1, !sec !{!"private"}
  %cmp8 = icmp ult i64 %13, %sub, !sec !{!"private"}
  br i1 %cmp8, label %if.then9, label %if.end11, !sec !{!"private"}

if.then9:                                         ; preds = %if.end6, !sec !{!"private"}
  %15 = load ptr, ptr %leaf, align 8, !sec !{!"private", !"private"}
  %16 = load i64, ptr %key.addr, align 8, !sec !{!"private", !"private"}
  %17 = load ptr, ptr %record_pointer, align 8, !sec !{!"private", !"private"}
  %call10 = call ptr @insert_into_leaf(ptr noundef %15, i64 noundef %16, ptr noundef %17), !sec !{!"call", !"private", !{!"private", !"private", !"private"}}
  store ptr %call10, ptr %leaf, align 8, !sec !{!"private", !"private"}
  %18 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  store ptr %18, ptr %retval, align 8, !sec !{!"private", !"private"}
  br label %return, !sec !{!"public"}

if.end11:                                         ; preds = %if.end6, !sec !{!"private"}
  %19 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %20 = load ptr, ptr %leaf, align 8, !sec !{!"private", !"private"}
  %21 = load i64, ptr %key.addr, align 8, !sec !{!"private", !"private"}
  %22 = load ptr, ptr %record_pointer, align 8, !sec !{!"private", !"private"}
  %call12 = call ptr @insert_into_leaf_after_splitting(ptr noundef %19, ptr noundef %20, i64 noundef %21, ptr noundef %22), !sec !{!"call", !"private", !{!"private", !"private", !"private", !"private"}}
  store ptr %call12, ptr %retval, align 8, !sec !{!"private", !"private"}
  br label %return, !sec !{!"public"}

return:                                           ; preds = %if.end11, %if.then9, %if.then4, %if.then, !sec !{!"private"}
  %23 = load ptr, ptr %retval, align 8, !sec !{!"private", !"private"}
  ret ptr %23, !sec !{!"private"}
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @get_neighbor_index(ptr noundef %n) #0 !sec !{!"private", !"private", !{!"private"}} {
entry:                                            ; !sec !{!"private"}
  %n.addr = alloca ptr, align 8, !sec !{!"private"}
  %i = alloca i64, align 8, !sec !{!"private"}
  store ptr %n, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  store i64 0, ptr %i, align 8, !sec !{!"public", !"private"}
  br label %for.cond, !sec !{!"public"}

for.cond:                                         ; preds = %for.inc, %entry, !sec !{!"private"}
  %0 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %1 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %parent = getelementptr inbounds %struct.node, ptr %1, i32 0, i32 2, !sec !{!"private", !"private", !"public", !"public"}
  %2 = load ptr, ptr %parent, align 8, !sec !{!"private", !"private"}
  %num_keys = getelementptr inbounds %struct.node, ptr %2, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %3 = load i64, ptr %num_keys, align 8, !sec !{!"private", !"private"}
  %cmp = icmp ule i64 %0, %3, !sec !{!"private"}
  br i1 %cmp, label %for.body, label %for.end, !sec !{!"private"}

for.body:                                         ; preds = %for.cond, !sec !{!"private"}
  %4 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %parent1 = getelementptr inbounds %struct.node, ptr %4, i32 0, i32 2, !sec !{!"private", !"private", !"public", !"public"}
  %5 = load ptr, ptr %parent1, align 8, !sec !{!"private", !"private"}
  %pointers = getelementptr inbounds %struct.node, ptr %5, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %6 = load ptr, ptr %pointers, align 8, !sec !{!"private", !"private"}
  %7 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx = getelementptr inbounds ptr, ptr %6, i64 %7, !sec !{!"private", !"private", !"private"}
  %8 = load ptr, ptr %arrayidx, align 8, !sec !{!"private", !"private"}
  %9 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %cmp2 = icmp eq ptr %8, %9, !sec !{!"private"}
  br i1 %cmp2, label %if.then, label %if.end, !sec !{!"private"}

if.then:                                          ; preds = %for.body, !sec !{!"private"}
  %10 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %sub = sub i64 %10, 1, !sec !{!"private"}
  ret i64 %sub, !sec !{!"private"}

if.end:                                           ; preds = %for.body, !sec !{!"private"}
  br label %for.inc, !sec !{!"public"}

for.inc:                                          ; preds = %if.end, !sec !{!"private"}
  %11 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %inc = add i64 %11, 1, !sec !{!"private"}
  store i64 %inc, ptr %i, align 8, !sec !{!"private", !"private"}
  br label %for.cond, !llvm.loop !39, !sec !{!"public"}

for.end:                                          ; preds = %for.cond, !sec !{!"private"}
  ret i64 -1, !sec !{!"private"}
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @remove_entry_from_node(ptr noundef %n, i64 noundef %key, ptr noundef %pointer) #0 !sec !{!"private", !"private", !{!"private", !"private", !"private"}} {
entry:                                            ; !sec !{!"private"}
  %n.addr = alloca ptr, align 8, !sec !{!"private"}
  %key.addr = alloca i64, align 8, !sec !{!"private"}
  %pointer.addr = alloca ptr, align 8, !sec !{!"private"}
  %i = alloca i64, align 8, !sec !{!"private"}
  %num_pointers = alloca i64, align 8, !sec !{!"private"}
  store ptr %n, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  store i64 %key, ptr %key.addr, align 8, !sec !{!"private", !"private"}
  store ptr %pointer, ptr %pointer.addr, align 8, !sec !{!"private", !"private"}
  store i64 0, ptr %i, align 8, !sec !{!"public", !"private"}
  br label %while.cond, !sec !{!"public"}

while.cond:                                       ; preds = %while.body, %entry, !sec !{!"private"}
  %0 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %keys = getelementptr inbounds %struct.node, ptr %0, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %1 = load ptr, ptr %keys, align 8, !sec !{!"private", !"private"}
  %2 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx = getelementptr inbounds i64, ptr %1, i64 %2, !sec !{!"private", !"private", !"private"}
  %3 = load i64, ptr %arrayidx, align 8, !sec !{!"private", !"private"}
  %4 = load i64, ptr %key.addr, align 8, !sec !{!"private", !"private"}
  %cmp = icmp ne i64 %3, %4, !sec !{!"private"}
  br i1 %cmp, label %while.body, label %while.end, !sec !{!"private"}

while.body:                                       ; preds = %while.cond, !sec !{!"private"}
  %5 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %inc = add i64 %5, 1, !sec !{!"private"}
  store i64 %inc, ptr %i, align 8, !sec !{!"private", !"private"}
  br label %while.cond, !llvm.loop !40, !sec !{!"public"}

while.end:                                        ; preds = %while.cond, !sec !{!"private"}
  %6 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %inc1 = add i64 %6, 1, !sec !{!"private"}
  store i64 %inc1, ptr %i, align 8, !sec !{!"private", !"private"}
  br label %for.cond, !sec !{!"public"}

for.cond:                                         ; preds = %for.inc, %while.end, !sec !{!"private"}
  %7 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %8 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %num_keys = getelementptr inbounds %struct.node, ptr %8, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %9 = load i64, ptr %num_keys, align 8, !sec !{!"private", !"private"}
  %cmp2 = icmp ult i64 %7, %9, !sec !{!"private"}
  br i1 %cmp2, label %for.body, label %for.end, !sec !{!"private"}

for.body:                                         ; preds = %for.cond, !sec !{!"private"}
  %10 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %keys3 = getelementptr inbounds %struct.node, ptr %10, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %11 = load ptr, ptr %keys3, align 8, !sec !{!"private", !"private"}
  %12 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx4 = getelementptr inbounds i64, ptr %11, i64 %12, !sec !{!"private", !"private", !"private"}
  %13 = load i64, ptr %arrayidx4, align 8, !sec !{!"private", !"private"}
  %14 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %keys5 = getelementptr inbounds %struct.node, ptr %14, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %15 = load ptr, ptr %keys5, align 8, !sec !{!"private", !"private"}
  %16 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %sub = sub i64 %16, 1, !sec !{!"private"}
  %arrayidx6 = getelementptr inbounds i64, ptr %15, i64 %sub, !sec !{!"private", !"private", !"private"}
  store i64 %13, ptr %arrayidx6, align 8, !sec !{!"private", !"private"}
  br label %for.inc, !sec !{!"public"}

for.inc:                                          ; preds = %for.body, !sec !{!"private"}
  %17 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %inc7 = add i64 %17, 1, !sec !{!"private"}
  store i64 %inc7, ptr %i, align 8, !sec !{!"private", !"private"}
  br label %for.cond, !llvm.loop !41, !sec !{!"public"}

for.end:                                          ; preds = %for.cond, !sec !{!"private"}
  %18 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %is_leaf = getelementptr inbounds %struct.node, ptr %18, i32 0, i32 3, !sec !{!"private", !"private", !"public", !"public"}
  %19 = load i8, ptr %is_leaf, align 8, !sec !{!"private", !"private"}
  %tobool = trunc i8 %19 to i1, !sec !{!"private"}
  br i1 %tobool, label %cond.true, label %cond.false, !sec !{!"private"}

cond.true:                                        ; preds = %for.end, !sec !{!"private"}
  %20 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %num_keys8 = getelementptr inbounds %struct.node, ptr %20, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %21 = load i64, ptr %num_keys8, align 8, !sec !{!"private", !"private"}
  br label %cond.end, !sec !{!"public"}

cond.false:                                       ; preds = %for.end, !sec !{!"private"}
  %22 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %num_keys9 = getelementptr inbounds %struct.node, ptr %22, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %23 = load i64, ptr %num_keys9, align 8, !sec !{!"private", !"private"}
  %add = add i64 %23, 1, !sec !{!"private"}
  br label %cond.end, !sec !{!"public"}

cond.end:                                         ; preds = %cond.false, %cond.true, !sec !{!"private"}
  %cond = phi i64 [ %21, %cond.true ], [ %add, %cond.false ], !sec !{!"private"}
  store i64 %cond, ptr %num_pointers, align 8, !sec !{!"private", !"private"}
  store i64 0, ptr %i, align 8, !sec !{!"public", !"private"}
  br label %while.cond10, !sec !{!"public"}

while.cond10:                                     ; preds = %while.body13, %cond.end, !sec !{!"private"}
  %24 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %pointers = getelementptr inbounds %struct.node, ptr %24, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %25 = load ptr, ptr %pointers, align 8, !sec !{!"private", !"private"}
  %26 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx11 = getelementptr inbounds ptr, ptr %25, i64 %26, !sec !{!"private", !"private", !"private"}
  %27 = load ptr, ptr %arrayidx11, align 8, !sec !{!"private", !"private"}
  %28 = load ptr, ptr %pointer.addr, align 8, !sec !{!"private", !"private"}
  %cmp12 = icmp ne ptr %27, %28, !sec !{!"private"}
  br i1 %cmp12, label %while.body13, label %while.end15, !sec !{!"private"}

while.body13:                                     ; preds = %while.cond10, !sec !{!"private"}
  %29 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %inc14 = add i64 %29, 1, !sec !{!"private"}
  store i64 %inc14, ptr %i, align 8, !sec !{!"private", !"private"}
  br label %while.cond10, !llvm.loop !42, !sec !{!"public"}

while.end15:                                      ; preds = %while.cond10, !sec !{!"private"}
  %30 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %inc16 = add i64 %30, 1, !sec !{!"private"}
  store i64 %inc16, ptr %i, align 8, !sec !{!"private", !"private"}
  br label %for.cond17, !sec !{!"public"}

for.cond17:                                       ; preds = %for.inc25, %while.end15, !sec !{!"private"}
  %31 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %32 = load i64, ptr %num_pointers, align 8, !sec !{!"private", !"private"}
  %cmp18 = icmp ult i64 %31, %32, !sec !{!"private"}
  br i1 %cmp18, label %for.body19, label %for.end27, !sec !{!"private"}

for.body19:                                       ; preds = %for.cond17, !sec !{!"private"}
  %33 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %pointers20 = getelementptr inbounds %struct.node, ptr %33, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %34 = load ptr, ptr %pointers20, align 8, !sec !{!"private", !"private"}
  %35 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx21 = getelementptr inbounds ptr, ptr %34, i64 %35, !sec !{!"private", !"private", !"private"}
  %36 = load ptr, ptr %arrayidx21, align 8, !sec !{!"private", !"private"}
  %37 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %pointers22 = getelementptr inbounds %struct.node, ptr %37, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %38 = load ptr, ptr %pointers22, align 8, !sec !{!"private", !"private"}
  %39 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %sub23 = sub i64 %39, 1, !sec !{!"private"}
  %arrayidx24 = getelementptr inbounds ptr, ptr %38, i64 %sub23, !sec !{!"private", !"private", !"private"}
  store ptr %36, ptr %arrayidx24, align 8, !sec !{!"private", !"private"}
  br label %for.inc25, !sec !{!"public"}

for.inc25:                                        ; preds = %for.body19, !sec !{!"private"}
  %40 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %inc26 = add i64 %40, 1, !sec !{!"private"}
  store i64 %inc26, ptr %i, align 8, !sec !{!"private", !"private"}
  br label %for.cond17, !llvm.loop !43, !sec !{!"public"}

for.end27:                                        ; preds = %for.cond17, !sec !{!"private"}
  %41 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %num_keys28 = getelementptr inbounds %struct.node, ptr %41, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %42 = load i64, ptr %num_keys28, align 8, !sec !{!"private", !"private"}
  %dec = add i64 %42, -1, !sec !{!"private"}
  store i64 %dec, ptr %num_keys28, align 8, !sec !{!"private", !"private"}
  %43 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %is_leaf29 = getelementptr inbounds %struct.node, ptr %43, i32 0, i32 3, !sec !{!"private", !"private", !"public", !"public"}
  %44 = load i8, ptr %is_leaf29, align 8, !sec !{!"private", !"private"}
  %tobool30 = trunc i8 %44 to i1, !sec !{!"private"}
  br i1 %tobool30, label %if.then, label %if.else, !sec !{!"private"}

if.then:                                          ; preds = %for.end27, !sec !{!"private"}
  %45 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %num_keys31 = getelementptr inbounds %struct.node, ptr %45, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %46 = load i64, ptr %num_keys31, align 8, !sec !{!"private", !"private"}
  store i64 %46, ptr %i, align 8, !sec !{!"private", !"private"}
  br label %for.cond32, !sec !{!"public"}

for.cond32:                                       ; preds = %for.inc38, %if.then, !sec !{!"private"}
  %47 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %48 = load i64, ptr @order, align 8, !sec !{!"private", !"private"}
  %sub33 = sub i64 %48, 1, !sec !{!"private"}
  %cmp34 = icmp ult i64 %47, %sub33, !sec !{!"private"}
  br i1 %cmp34, label %for.body35, label %for.end40, !sec !{!"private"}

for.body35:                                       ; preds = %for.cond32, !sec !{!"private"}
  %49 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %pointers36 = getelementptr inbounds %struct.node, ptr %49, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %50 = load ptr, ptr %pointers36, align 8, !sec !{!"private", !"private"}
  %51 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx37 = getelementptr inbounds ptr, ptr %50, i64 %51, !sec !{!"private", !"private", !"private"}
  store ptr null, ptr %arrayidx37, align 8, !sec !{!"public", !"private"}
  br label %for.inc38, !sec !{!"public"}

for.inc38:                                        ; preds = %for.body35, !sec !{!"private"}
  %52 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %inc39 = add i64 %52, 1, !sec !{!"private"}
  store i64 %inc39, ptr %i, align 8, !sec !{!"private", !"private"}
  br label %for.cond32, !llvm.loop !44, !sec !{!"public"}

for.end40:                                        ; preds = %for.cond32, !sec !{!"private"}
  br label %if.end, !sec !{!"public"}

if.else:                                          ; preds = %for.end27, !sec !{!"private"}
  %53 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %num_keys41 = getelementptr inbounds %struct.node, ptr %53, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %54 = load i64, ptr %num_keys41, align 8, !sec !{!"private", !"private"}
  %add42 = add i64 %54, 1, !sec !{!"private"}
  store i64 %add42, ptr %i, align 8, !sec !{!"private", !"private"}
  br label %for.cond43, !sec !{!"public"}

for.cond43:                                       ; preds = %for.inc48, %if.else, !sec !{!"private"}
  %55 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %56 = load i64, ptr @order, align 8, !sec !{!"private", !"private"}
  %cmp44 = icmp ult i64 %55, %56, !sec !{!"private"}
  br i1 %cmp44, label %for.body45, label %for.end50, !sec !{!"private"}

for.body45:                                       ; preds = %for.cond43, !sec !{!"private"}
  %57 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %pointers46 = getelementptr inbounds %struct.node, ptr %57, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %58 = load ptr, ptr %pointers46, align 8, !sec !{!"private", !"private"}
  %59 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx47 = getelementptr inbounds ptr, ptr %58, i64 %59, !sec !{!"private", !"private", !"private"}
  store ptr null, ptr %arrayidx47, align 8, !sec !{!"public", !"private"}
  br label %for.inc48, !sec !{!"public"}

for.inc48:                                        ; preds = %for.body45, !sec !{!"private"}
  %60 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %inc49 = add i64 %60, 1, !sec !{!"private"}
  store i64 %inc49, ptr %i, align 8, !sec !{!"private", !"private"}
  br label %for.cond43, !llvm.loop !45, !sec !{!"public"}

for.end50:                                        ; preds = %for.cond43, !sec !{!"private"}
  br label %if.end, !sec !{!"public"}

if.end:                                           ; preds = %for.end50, %for.end40, !sec !{!"private"}
  %61 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  ret ptr %61, !sec !{!"private"}
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @adjust_root(ptr noundef %root) #0 !sec !{!"private", !"private", !{!"private"}} {
entry:                                            ; !sec !{!"private"}
  %retval = alloca ptr, align 8, !sec !{!"private"}
  %root.addr = alloca ptr, align 8, !sec !{!"private"}
  %new_root = alloca ptr, align 8, !sec !{!"private"}
  store ptr %root, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %0 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %num_keys = getelementptr inbounds %struct.node, ptr %0, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %1 = load i64, ptr %num_keys, align 8, !sec !{!"private", !"private"}
  %cmp = icmp ugt i64 %1, 0, !sec !{!"private"}
  br i1 %cmp, label %if.then, label %if.end, !sec !{!"private"}

if.then:                                          ; preds = %entry, !sec !{!"private"}
  %2 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  store ptr %2, ptr %retval, align 8, !sec !{!"private", !"private"}
  br label %return, !sec !{!"public"}

if.end:                                           ; preds = %entry, !sec !{!"private"}
  %3 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %is_leaf = getelementptr inbounds %struct.node, ptr %3, i32 0, i32 3, !sec !{!"private", !"private", !"public", !"public"}
  %4 = load i8, ptr %is_leaf, align 8, !sec !{!"private", !"private"}
  %tobool = trunc i8 %4 to i1, !sec !{!"private"}
  br i1 %tobool, label %if.else, label %if.then1, !sec !{!"private"}

if.then1:                                         ; preds = %if.end, !sec !{!"private"}
  %5 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %pointers = getelementptr inbounds %struct.node, ptr %5, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %6 = load ptr, ptr %pointers, align 8, !sec !{!"private", !"private"}
  %arrayidx = getelementptr inbounds ptr, ptr %6, i64 0, !sec !{!"private", !"private", !"public"}
  %7 = load ptr, ptr %arrayidx, align 8, !sec !{!"private", !"private"}
  store ptr %7, ptr %new_root, align 8, !sec !{!"private", !"private"}
  %8 = load ptr, ptr %new_root, align 8, !sec !{!"private", !"private"}
  %parent = getelementptr inbounds %struct.node, ptr %8, i32 0, i32 2, !sec !{!"private", !"private", !"public", !"public"}
  store ptr null, ptr %parent, align 8, !sec !{!"public", !"private"}
  br label %if.end2, !sec !{!"public"}

if.else:                                          ; preds = %if.end, !sec !{!"private"}
  store ptr null, ptr %new_root, align 8, !sec !{!"public", !"private"}
  br label %if.end2, !sec !{!"public"}

if.end2:                                          ; preds = %if.else, %if.then1, !sec !{!"private"}
  %9 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %keys = getelementptr inbounds %struct.node, ptr %9, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %10 = load ptr, ptr %keys, align 8, !sec !{!"private", !"private"}
  call void @free(ptr noundef %10) #8, !sec !{!"public"}
  %11 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %pointers3 = getelementptr inbounds %struct.node, ptr %11, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %12 = load ptr, ptr %pointers3, align 8, !sec !{!"private", !"private"}
  call void @free(ptr noundef %12) #8, !sec !{!"public"}
  %13 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  call void @free_node(ptr noundef %13), !sec !{!"call", !"void", !{!"private"}}
  %14 = load ptr, ptr %new_root, align 8, !sec !{!"private", !"private"}
  store ptr %14, ptr %retval, align 8, !sec !{!"private", !"private"}
  br label %return, !sec !{!"public"}

return:                                           ; preds = %if.end2, %if.then, !sec !{!"private"}
  %15 = load ptr, ptr %retval, align 8, !sec !{!"private", !"private"}
  ret ptr %15, !sec !{!"private"}
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @coalesce_nodes(ptr noundef %root, ptr noundef %n, ptr noundef %neighbor, i64 noundef %neighbor_index, i64 noundef %k_prime) #0 !sec !{!"private", !"private", !{!"private", !"private", !"private", !"private", !"private"}} {
entry:                                            ; !sec !{!"private"}
  %root.addr = alloca ptr, align 8, !sec !{!"private"}
  %n.addr = alloca ptr, align 8, !sec !{!"private"}
  %neighbor.addr = alloca ptr, align 8, !sec !{!"private"}
  %neighbor_index.addr = alloca i64, align 8, !sec !{!"private"}
  %k_prime.addr = alloca i64, align 8, !sec !{!"private"}
  %i = alloca i64, align 8, !sec !{!"private"}
  %j = alloca i64, align 8, !sec !{!"private"}
  %neighbor_insertion_index = alloca i64, align 8, !sec !{!"private"}
  %n_end = alloca i64, align 8, !sec !{!"private"}
  %tmp = alloca ptr, align 8, !sec !{!"private"}
  store ptr %root, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  store ptr %n, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  store ptr %neighbor, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  store i64 %neighbor_index, ptr %neighbor_index.addr, align 8, !sec !{!"private", !"private"}
  store i64 %k_prime, ptr %k_prime.addr, align 8, !sec !{!"private", !"private"}
  %0 = load i64, ptr %neighbor_index.addr, align 8, !sec !{!"private", !"private"}
  %cmp = icmp eq i64 %0, -1, !sec !{!"private"}
  br i1 %cmp, label %if.then, label %if.end, !sec !{!"private"}

if.then:                                          ; preds = %entry, !sec !{!"private"}
  %1 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  store ptr %1, ptr %tmp, align 8, !sec !{!"private", !"private"}
  %2 = load ptr, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  store ptr %2, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %3 = load ptr, ptr %tmp, align 8, !sec !{!"private", !"private"}
  store ptr %3, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  br label %if.end, !sec !{!"public"}

if.end:                                           ; preds = %if.then, %entry, !sec !{!"private"}
  %4 = load ptr, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  %num_keys = getelementptr inbounds %struct.node, ptr %4, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %5 = load i64, ptr %num_keys, align 8, !sec !{!"private", !"private"}
  store i64 %5, ptr %neighbor_insertion_index, align 8, !sec !{!"private", !"private"}
  %6 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %is_leaf = getelementptr inbounds %struct.node, ptr %6, i32 0, i32 3, !sec !{!"private", !"private", !"public", !"public"}
  %7 = load i8, ptr %is_leaf, align 8, !sec !{!"private", !"private"}
  %tobool = trunc i8 %7 to i1, !sec !{!"private"}
  br i1 %tobool, label %if.else, label %if.then1, !sec !{!"private"}

if.then1:                                         ; preds = %if.end, !sec !{!"private"}
  %8 = load i64, ptr %k_prime.addr, align 8, !sec !{!"private", !"private"}
  %9 = load ptr, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  %keys = getelementptr inbounds %struct.node, ptr %9, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %10 = load ptr, ptr %keys, align 8, !sec !{!"private", !"private"}
  %11 = load i64, ptr %neighbor_insertion_index, align 8, !sec !{!"private", !"private"}
  %arrayidx = getelementptr inbounds i64, ptr %10, i64 %11, !sec !{!"private", !"private", !"private"}
  store i64 %8, ptr %arrayidx, align 8, !sec !{!"private", !"private"}
  %12 = load ptr, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  %num_keys2 = getelementptr inbounds %struct.node, ptr %12, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %13 = load i64, ptr %num_keys2, align 8, !sec !{!"private", !"private"}
  %inc = add i64 %13, 1, !sec !{!"private"}
  store i64 %inc, ptr %num_keys2, align 8, !sec !{!"private", !"private"}
  %14 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %num_keys3 = getelementptr inbounds %struct.node, ptr %14, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %15 = load i64, ptr %num_keys3, align 8, !sec !{!"private", !"private"}
  store i64 %15, ptr %n_end, align 8, !sec !{!"private", !"private"}
  %16 = load i64, ptr %neighbor_insertion_index, align 8, !sec !{!"private", !"private"}
  %add = add i64 %16, 1, !sec !{!"private"}
  store i64 %add, ptr %i, align 8, !sec !{!"private", !"private"}
  store i64 0, ptr %j, align 8, !sec !{!"public", !"private"}
  br label %for.cond, !sec !{!"public"}

for.cond:                                         ; preds = %for.inc, %if.then1, !sec !{!"private"}
  %17 = load i64, ptr %j, align 8, !sec !{!"private", !"private"}
  %18 = load i64, ptr %n_end, align 8, !sec !{!"private", !"private"}
  %cmp4 = icmp ult i64 %17, %18, !sec !{!"private"}
  br i1 %cmp4, label %for.body, label %for.end, !sec !{!"private"}

for.body:                                         ; preds = %for.cond, !sec !{!"private"}
  %19 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %keys5 = getelementptr inbounds %struct.node, ptr %19, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %20 = load ptr, ptr %keys5, align 8, !sec !{!"private", !"private"}
  %21 = load i64, ptr %j, align 8, !sec !{!"private", !"private"}
  %arrayidx6 = getelementptr inbounds i64, ptr %20, i64 %21, !sec !{!"private", !"private", !"private"}
  %22 = load i64, ptr %arrayidx6, align 8, !sec !{!"private", !"private"}
  %23 = load ptr, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  %keys7 = getelementptr inbounds %struct.node, ptr %23, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %24 = load ptr, ptr %keys7, align 8, !sec !{!"private", !"private"}
  %25 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx8 = getelementptr inbounds i64, ptr %24, i64 %25, !sec !{!"private", !"private", !"private"}
  store i64 %22, ptr %arrayidx8, align 8, !sec !{!"private", !"private"}
  %26 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %pointers = getelementptr inbounds %struct.node, ptr %26, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %27 = load ptr, ptr %pointers, align 8, !sec !{!"private", !"private"}
  %28 = load i64, ptr %j, align 8, !sec !{!"private", !"private"}
  %arrayidx9 = getelementptr inbounds ptr, ptr %27, i64 %28, !sec !{!"private", !"private", !"private"}
  %29 = load ptr, ptr %arrayidx9, align 8, !sec !{!"private", !"private"}
  %30 = load ptr, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  %pointers10 = getelementptr inbounds %struct.node, ptr %30, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %31 = load ptr, ptr %pointers10, align 8, !sec !{!"private", !"private"}
  %32 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx11 = getelementptr inbounds ptr, ptr %31, i64 %32, !sec !{!"private", !"private", !"private"}
  store ptr %29, ptr %arrayidx11, align 8, !sec !{!"private", !"private"}
  %33 = load ptr, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  %num_keys12 = getelementptr inbounds %struct.node, ptr %33, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %34 = load i64, ptr %num_keys12, align 8, !sec !{!"private", !"private"}
  %inc13 = add i64 %34, 1, !sec !{!"private"}
  store i64 %inc13, ptr %num_keys12, align 8, !sec !{!"private", !"private"}
  %35 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %num_keys14 = getelementptr inbounds %struct.node, ptr %35, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %36 = load i64, ptr %num_keys14, align 8, !sec !{!"private", !"private"}
  %dec = add i64 %36, -1, !sec !{!"private"}
  store i64 %dec, ptr %num_keys14, align 8, !sec !{!"private", !"private"}
  br label %for.inc, !sec !{!"public"}

for.inc:                                          ; preds = %for.body, !sec !{!"private"}
  %37 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %inc15 = add i64 %37, 1, !sec !{!"private"}
  store i64 %inc15, ptr %i, align 8, !sec !{!"private", !"private"}
  %38 = load i64, ptr %j, align 8, !sec !{!"private", !"private"}
  %inc16 = add i64 %38, 1, !sec !{!"private"}
  store i64 %inc16, ptr %j, align 8, !sec !{!"private", !"private"}
  br label %for.cond, !llvm.loop !46, !sec !{!"public"}

for.end:                                          ; preds = %for.cond, !sec !{!"private"}
  %39 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %pointers17 = getelementptr inbounds %struct.node, ptr %39, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %40 = load ptr, ptr %pointers17, align 8, !sec !{!"private", !"private"}
  %41 = load i64, ptr %j, align 8, !sec !{!"private", !"private"}
  %arrayidx18 = getelementptr inbounds ptr, ptr %40, i64 %41, !sec !{!"private", !"private", !"private"}
  %42 = load ptr, ptr %arrayidx18, align 8, !sec !{!"private", !"private"}
  %43 = load ptr, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  %pointers19 = getelementptr inbounds %struct.node, ptr %43, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %44 = load ptr, ptr %pointers19, align 8, !sec !{!"private", !"private"}
  %45 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx20 = getelementptr inbounds ptr, ptr %44, i64 %45, !sec !{!"private", !"private", !"private"}
  store ptr %42, ptr %arrayidx20, align 8, !sec !{!"private", !"private"}
  store i64 0, ptr %i, align 8, !sec !{!"public", !"private"}
  br label %for.cond21, !sec !{!"public"}

for.cond21:                                       ; preds = %for.inc28, %for.end, !sec !{!"private"}
  %46 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %47 = load ptr, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  %num_keys22 = getelementptr inbounds %struct.node, ptr %47, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %48 = load i64, ptr %num_keys22, align 8, !sec !{!"private", !"private"}
  %add23 = add i64 %48, 1, !sec !{!"private"}
  %cmp24 = icmp ult i64 %46, %add23, !sec !{!"private"}
  br i1 %cmp24, label %for.body25, label %for.end30, !sec !{!"private"}

for.body25:                                       ; preds = %for.cond21, !sec !{!"private"}
  %49 = load ptr, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  %pointers26 = getelementptr inbounds %struct.node, ptr %49, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %50 = load ptr, ptr %pointers26, align 8, !sec !{!"private", !"private"}
  %51 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx27 = getelementptr inbounds ptr, ptr %50, i64 %51, !sec !{!"private", !"private", !"private"}
  %52 = load ptr, ptr %arrayidx27, align 8, !sec !{!"private", !"private"}
  store ptr %52, ptr %tmp, align 8, !sec !{!"private", !"private"}
  %53 = load ptr, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  %54 = load ptr, ptr %tmp, align 8, !sec !{!"private", !"private"}
  %parent = getelementptr inbounds %struct.node, ptr %54, i32 0, i32 2, !sec !{!"private", !"private", !"public", !"public"}
  store ptr %53, ptr %parent, align 8, !sec !{!"private", !"private"}
  br label %for.inc28, !sec !{!"public"}

for.inc28:                                        ; preds = %for.body25, !sec !{!"private"}
  %55 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %inc29 = add i64 %55, 1, !sec !{!"private"}
  store i64 %inc29, ptr %i, align 8, !sec !{!"private", !"private"}
  br label %for.cond21, !llvm.loop !47, !sec !{!"public"}

for.end30:                                        ; preds = %for.cond21, !sec !{!"private"}
  br label %if.end54, !sec !{!"public"}

if.else:                                          ; preds = %if.end, !sec !{!"private"}
  %56 = load i64, ptr %neighbor_insertion_index, align 8, !sec !{!"private", !"private"}
  store i64 %56, ptr %i, align 8, !sec !{!"private", !"private"}
  store i64 0, ptr %j, align 8, !sec !{!"public", !"private"}
  br label %for.cond31, !sec !{!"public"}

for.cond31:                                       ; preds = %for.inc45, %if.else, !sec !{!"private"}
  %57 = load i64, ptr %j, align 8, !sec !{!"private", !"private"}
  %58 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %num_keys32 = getelementptr inbounds %struct.node, ptr %58, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %59 = load i64, ptr %num_keys32, align 8, !sec !{!"private", !"private"}
  %cmp33 = icmp ult i64 %57, %59, !sec !{!"private"}
  br i1 %cmp33, label %for.body34, label %for.end48, !sec !{!"private"}

for.body34:                                       ; preds = %for.cond31, !sec !{!"private"}
  %60 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %keys35 = getelementptr inbounds %struct.node, ptr %60, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %61 = load ptr, ptr %keys35, align 8, !sec !{!"private", !"private"}
  %62 = load i64, ptr %j, align 8, !sec !{!"private", !"private"}
  %arrayidx36 = getelementptr inbounds i64, ptr %61, i64 %62, !sec !{!"private", !"private", !"private"}
  %63 = load i64, ptr %arrayidx36, align 8, !sec !{!"private", !"private"}
  %64 = load ptr, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  %keys37 = getelementptr inbounds %struct.node, ptr %64, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %65 = load ptr, ptr %keys37, align 8, !sec !{!"private", !"private"}
  %66 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx38 = getelementptr inbounds i64, ptr %65, i64 %66, !sec !{!"private", !"private", !"private"}
  store i64 %63, ptr %arrayidx38, align 8, !sec !{!"private", !"private"}
  %67 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %pointers39 = getelementptr inbounds %struct.node, ptr %67, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %68 = load ptr, ptr %pointers39, align 8, !sec !{!"private", !"private"}
  %69 = load i64, ptr %j, align 8, !sec !{!"private", !"private"}
  %arrayidx40 = getelementptr inbounds ptr, ptr %68, i64 %69, !sec !{!"private", !"private", !"private"}
  %70 = load ptr, ptr %arrayidx40, align 8, !sec !{!"private", !"private"}
  %71 = load ptr, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  %pointers41 = getelementptr inbounds %struct.node, ptr %71, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %72 = load ptr, ptr %pointers41, align 8, !sec !{!"private", !"private"}
  %73 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx42 = getelementptr inbounds ptr, ptr %72, i64 %73, !sec !{!"private", !"private", !"private"}
  store ptr %70, ptr %arrayidx42, align 8, !sec !{!"private", !"private"}
  %74 = load ptr, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  %num_keys43 = getelementptr inbounds %struct.node, ptr %74, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %75 = load i64, ptr %num_keys43, align 8, !sec !{!"private", !"private"}
  %inc44 = add i64 %75, 1, !sec !{!"private"}
  store i64 %inc44, ptr %num_keys43, align 8, !sec !{!"private", !"private"}
  br label %for.inc45, !sec !{!"public"}

for.inc45:                                        ; preds = %for.body34, !sec !{!"private"}
  %76 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %inc46 = add i64 %76, 1, !sec !{!"private"}
  store i64 %inc46, ptr %i, align 8, !sec !{!"private", !"private"}
  %77 = load i64, ptr %j, align 8, !sec !{!"private", !"private"}
  %inc47 = add i64 %77, 1, !sec !{!"private"}
  store i64 %inc47, ptr %j, align 8, !sec !{!"private", !"private"}
  br label %for.cond31, !llvm.loop !48, !sec !{!"public"}

for.end48:                                        ; preds = %for.cond31, !sec !{!"private"}
  %78 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %pointers49 = getelementptr inbounds %struct.node, ptr %78, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %79 = load ptr, ptr %pointers49, align 8, !sec !{!"private", !"private"}
  %80 = load i64, ptr @order, align 8, !sec !{!"private", !"private"}
  %sub = sub i64 %80, 1, !sec !{!"private"}
  %arrayidx50 = getelementptr inbounds ptr, ptr %79, i64 %sub, !sec !{!"private", !"private", !"private"}
  %81 = load ptr, ptr %arrayidx50, align 8, !sec !{!"private", !"private"}
  %82 = load ptr, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  %pointers51 = getelementptr inbounds %struct.node, ptr %82, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %83 = load ptr, ptr %pointers51, align 8, !sec !{!"private", !"private"}
  %84 = load i64, ptr @order, align 8, !sec !{!"private", !"private"}
  %sub52 = sub i64 %84, 1, !sec !{!"private"}
  %arrayidx53 = getelementptr inbounds ptr, ptr %83, i64 %sub52, !sec !{!"private", !"private", !"private"}
  store ptr %81, ptr %arrayidx53, align 8, !sec !{!"private", !"private"}
  br label %if.end54, !sec !{!"public"}

if.end54:                                         ; preds = %for.end48, %for.end30, !sec !{!"private"}
  %85 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %86 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %parent55 = getelementptr inbounds %struct.node, ptr %86, i32 0, i32 2, !sec !{!"private", !"private", !"public", !"public"}
  %87 = load ptr, ptr %parent55, align 8, !sec !{!"private", !"private"}
  %88 = load i64, ptr %k_prime.addr, align 8, !sec !{!"private", !"private"}
  %89 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %call = call ptr @delete_entry(ptr noundef %85, ptr noundef %87, i64 noundef %88, ptr noundef %89), !sec !{!"call", !"private", !{!"private", !"private", !"private", !"private"}}
  store ptr %call, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %90 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %keys56 = getelementptr inbounds %struct.node, ptr %90, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %91 = load ptr, ptr %keys56, align 8, !sec !{!"private", !"private"}
  call void @free(ptr noundef %91) #8, !sec !{!"public"}
  %92 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %pointers57 = getelementptr inbounds %struct.node, ptr %92, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %93 = load ptr, ptr %pointers57, align 8, !sec !{!"private", !"private"}
  call void @free(ptr noundef %93) #8, !sec !{!"public"}
  %94 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  call void @free_node(ptr noundef %94), !sec !{!"call", !"void", !{!"private"}}
  %95 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  ret ptr %95, !sec !{!"private"}
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @delete_entry(ptr noundef %root, ptr noundef %n, i64 noundef %key, ptr noundef %pointer) #0 !sec !{!"private", !"private", !{!"private", !"private", !"private", !"nosec"}} {
entry:                                            ; !sec !{!"private"}
  %retval = alloca ptr, align 8, !sec !{!"private"}
  %root.addr = alloca ptr, align 8, !sec !{!"private"}
  %n.addr = alloca ptr, align 8, !sec !{!"private"}
  %key.addr = alloca i64, align 8, !sec !{!"private"}
  %pointer.addr = alloca ptr, align 8, !sec !{!"private"}
  %min_keys = alloca i64, align 8, !sec !{!"private"}
  %neighbor = alloca ptr, align 8, !sec !{!"private"}
  %neighbor_index = alloca i64, align 8, !sec !{!"private"}
  %k_prime_index = alloca i64, align 8, !sec !{!"private"}
  %k_prime = alloca i64, align 8, !sec !{!"private"}
  %capacity = alloca i64, align 8, !sec !{!"private"}
  store ptr %root, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  store ptr %n, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  store i64 %key, ptr %key.addr, align 8, !sec !{!"private", !"private"}
  store ptr %pointer, ptr %pointer.addr, align 8, !sec !{!"private", !"private"}
  %0 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %1 = load i64, ptr %key.addr, align 8, !sec !{!"private", !"private"}
  %2 = load ptr, ptr %pointer.addr, align 8, !sec !{!"private", !"private"}
  %call = call ptr @remove_entry_from_node(ptr noundef %0, i64 noundef %1, ptr noundef %2), !sec !{!"call", !"private", !{!"private", !"private", !"private"}}
  store ptr %call, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %3 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %4 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %cmp = icmp eq ptr %3, %4, !sec !{!"private"}
  br i1 %cmp, label %if.then, label %if.end, !sec !{!"private"}

if.then:                                          ; preds = %entry, !sec !{!"private"}
  %5 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %call1 = call ptr @adjust_root(ptr noundef %5), !sec !{!"call", !"private", !{!"private"}}
  store ptr %call1, ptr %retval, align 8, !sec !{!"private", !"private"}
  br label %return, !sec !{!"public"}

if.end:                                           ; preds = %entry, !sec !{!"private"}
  %6 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %is_leaf = getelementptr inbounds %struct.node, ptr %6, i32 0, i32 3, !sec !{!"private", !"private", !"public", !"public"}
  %7 = load i8, ptr %is_leaf, align 8, !sec !{!"private", !"private"}
  %tobool = trunc i8 %7 to i1, !sec !{!"private"}
  br i1 %tobool, label %cond.true, label %cond.false, !sec !{!"private"}

cond.true:                                        ; preds = %if.end, !sec !{!"private"}
  %8 = load i64, ptr @order, align 8, !sec !{!"private", !"private"}
  %sub = sub i64 %8, 1, !sec !{!"private"}
  %call2 = call i64 @cut(i64 noundef %sub), !sec !{!"call", !"private", !{!"private"}}
  br label %cond.end, !sec !{!"public"}

cond.false:                                       ; preds = %if.end, !sec !{!"private"}
  %9 = load i64, ptr @order, align 8, !sec !{!"private", !"private"}
  %call3 = call i64 @cut(i64 noundef %9), !sec !{!"call", !"private", !{!"private"}}
  %sub4 = sub i64 %call3, 1, !sec !{!"private"}
  br label %cond.end, !sec !{!"public"}

cond.end:                                         ; preds = %cond.false, %cond.true, !sec !{!"private"}
  %cond = phi i64 [ %call2, %cond.true ], [ %sub4, %cond.false ], !sec !{!"private"}
  store i64 %cond, ptr %min_keys, align 8, !sec !{!"private", !"private"}
  %10 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %num_keys = getelementptr inbounds %struct.node, ptr %10, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %11 = load i64, ptr %num_keys, align 8, !sec !{!"private", !"private"}
  %12 = load i64, ptr %min_keys, align 8, !sec !{!"private", !"private"}
  %cmp5 = icmp uge i64 %11, %12, !sec !{!"private"}
  br i1 %cmp5, label %if.then6, label %if.end7, !sec !{!"private"}

if.then6:                                         ; preds = %cond.end, !sec !{!"private"}
  %13 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  store ptr %13, ptr %retval, align 8, !sec !{!"private", !"private"}
  br label %return, !sec !{!"public"}

if.end7:                                          ; preds = %cond.end, !sec !{!"private"}
  %14 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %call8 = call i64 @get_neighbor_index(ptr noundef %14), !sec !{!"call", !"private", !{!"private"}}
  store i64 %call8, ptr %neighbor_index, align 8, !sec !{!"private", !"private"}
  %15 = load i64, ptr %neighbor_index, align 8, !sec !{!"private", !"private"}
  %cmp9 = icmp eq i64 %15, -1, !sec !{!"private"}
  br i1 %cmp9, label %cond.true10, label %cond.false11, !sec !{!"private"}

cond.true10:                                      ; preds = %if.end7, !sec !{!"private"}
  br label %cond.end12, !sec !{!"public"}

cond.false11:                                     ; preds = %if.end7, !sec !{!"private"}
  %16 = load i64, ptr %neighbor_index, align 8, !sec !{!"private", !"private"}
  br label %cond.end12, !sec !{!"public"}

cond.end12:                                       ; preds = %cond.false11, %cond.true10, !sec !{!"private"}
  %cond13 = phi i64 [ 0, %cond.true10 ], [ %16, %cond.false11 ], !sec !{!"private"}
  store i64 %cond13, ptr %k_prime_index, align 8, !sec !{!"private", !"private"}
  %17 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %parent = getelementptr inbounds %struct.node, ptr %17, i32 0, i32 2, !sec !{!"private", !"private", !"public", !"public"}
  %18 = load ptr, ptr %parent, align 8, !sec !{!"private", !"private"}
  %keys = getelementptr inbounds %struct.node, ptr %18, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %19 = load ptr, ptr %keys, align 8, !sec !{!"private", !"private"}
  %20 = load i64, ptr %k_prime_index, align 8, !sec !{!"private", !"private"}
  %arrayidx = getelementptr inbounds i64, ptr %19, i64 %20, !sec !{!"private", !"private", !"private"}
  %21 = load i64, ptr %arrayidx, align 8, !sec !{!"private", !"private"}
  store i64 %21, ptr %k_prime, align 8, !sec !{!"private", !"private"}
  %22 = load i64, ptr %neighbor_index, align 8, !sec !{!"private", !"private"}
  %cmp14 = icmp eq i64 %22, -1, !sec !{!"private"}
  br i1 %cmp14, label %cond.true15, label %cond.false18, !sec !{!"private"}

cond.true15:                                      ; preds = %cond.end12, !sec !{!"private"}
  %23 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %parent16 = getelementptr inbounds %struct.node, ptr %23, i32 0, i32 2, !sec !{!"private", !"private", !"public", !"public"}
  %24 = load ptr, ptr %parent16, align 8, !sec !{!"private", !"private"}
  %pointers = getelementptr inbounds %struct.node, ptr %24, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %25 = load ptr, ptr %pointers, align 8, !sec !{!"private", !"private"}
  %arrayidx17 = getelementptr inbounds ptr, ptr %25, i64 1, !sec !{!"private", !"private", !"public"}
  %26 = load ptr, ptr %arrayidx17, align 8, !sec !{!"private", !"private"}
  br label %cond.end22, !sec !{!"public"}

cond.false18:                                     ; preds = %cond.end12, !sec !{!"private"}
  %27 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %parent19 = getelementptr inbounds %struct.node, ptr %27, i32 0, i32 2, !sec !{!"private", !"private", !"public", !"public"}
  %28 = load ptr, ptr %parent19, align 8, !sec !{!"private", !"private"}
  %pointers20 = getelementptr inbounds %struct.node, ptr %28, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %29 = load ptr, ptr %pointers20, align 8, !sec !{!"private", !"private"}
  %30 = load i64, ptr %neighbor_index, align 8, !sec !{!"private", !"private"}
  %arrayidx21 = getelementptr inbounds ptr, ptr %29, i64 %30, !sec !{!"private", !"private", !"private"}
  %31 = load ptr, ptr %arrayidx21, align 8, !sec !{!"private", !"private"}
  br label %cond.end22, !sec !{!"public"}

cond.end22:                                       ; preds = %cond.false18, %cond.true15, !sec !{!"private"}
  %cond23 = phi ptr [ %26, %cond.true15 ], [ %31, %cond.false18 ], !sec !{!"private"}
  store ptr %cond23, ptr %neighbor, align 8, !sec !{!"private", !"private"}
  %32 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %is_leaf24 = getelementptr inbounds %struct.node, ptr %32, i32 0, i32 3, !sec !{!"private", !"private", !"public", !"public"}
  %33 = load i8, ptr %is_leaf24, align 8, !sec !{!"private", !"private"}
  %tobool25 = trunc i8 %33 to i1, !sec !{!"private"}
  br i1 %tobool25, label %cond.true26, label %cond.false27, !sec !{!"private"}

cond.true26:                                      ; preds = %cond.end22, !sec !{!"private"}
  %34 = load i64, ptr @order, align 8, !sec !{!"private", !"private"}
  br label %cond.end29, !sec !{!"public"}

cond.false27:                                     ; preds = %cond.end22, !sec !{!"private"}
  %35 = load i64, ptr @order, align 8, !sec !{!"private", !"private"}
  %sub28 = sub i64 %35, 1, !sec !{!"private"}
  br label %cond.end29, !sec !{!"public"}

cond.end29:                                       ; preds = %cond.false27, %cond.true26, !sec !{!"private"}
  %cond30 = phi i64 [ %34, %cond.true26 ], [ %sub28, %cond.false27 ], !sec !{!"private"}
  store i64 %cond30, ptr %capacity, align 8, !sec !{!"private", !"private"}
  %36 = load ptr, ptr %neighbor, align 8, !sec !{!"private", !"private"}
  %num_keys31 = getelementptr inbounds %struct.node, ptr %36, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %37 = load i64, ptr %num_keys31, align 8, !sec !{!"private", !"private"}
  %38 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %num_keys32 = getelementptr inbounds %struct.node, ptr %38, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %39 = load i64, ptr %num_keys32, align 8, !sec !{!"private", !"private"}
  %add = add i64 %37, %39, !sec !{!"private"}
  %40 = load i64, ptr %capacity, align 8, !sec !{!"private", !"private"}
  %cmp33 = icmp ult i64 %add, %40, !sec !{!"private"}
  br i1 %cmp33, label %if.then34, label %if.else, !sec !{!"private"}

if.then34:                                        ; preds = %cond.end29, !sec !{!"private"}
  %41 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %42 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %43 = load ptr, ptr %neighbor, align 8, !sec !{!"private", !"private"}
  %44 = load i64, ptr %neighbor_index, align 8, !sec !{!"private", !"private"}
  %45 = load i64, ptr %k_prime, align 8, !sec !{!"private", !"private"}
  %call35 = call ptr @coalesce_nodes(ptr noundef %41, ptr noundef %42, ptr noundef %43, i64 noundef %44, i64 noundef %45), !sec !{!"call", !"private", !{!"private", !"private", !"private", !"private", !"private"}}
  store ptr %call35, ptr %retval, align 8, !sec !{!"private", !"private"}
  br label %return, !sec !{!"public"}

if.else:                                          ; preds = %cond.end29, !sec !{!"private"}
  %46 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %47 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %48 = load ptr, ptr %neighbor, align 8, !sec !{!"private", !"private"}
  %49 = load i64, ptr %neighbor_index, align 8, !sec !{!"private", !"private"}
  %50 = load i64, ptr %k_prime_index, align 8, !sec !{!"private", !"private"}
  %51 = load i64, ptr %k_prime, align 8, !sec !{!"private", !"private"}
  %call36 = call ptr @redistribute_nodes(ptr noundef %46, ptr noundef %47, ptr noundef %48, i64 noundef %49, i64 noundef %50, i64 noundef %51), !sec !{!"call", !"private", !{!"private", !"private", !"private", !"private", !"private", !"private"}}
  store ptr %call36, ptr %retval, align 8, !sec !{!"private", !"private"}
  br label %return, !sec !{!"public"}

return:                                           ; preds = %if.else, %if.then34, %if.then6, %if.then, !sec !{!"private"}
  %52 = load ptr, ptr %retval, align 8, !sec !{!"private", !"private"}
  ret ptr %52, !sec !{!"private"}
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @redistribute_nodes(ptr noundef %root, ptr noundef %n, ptr noundef %neighbor, i64 noundef %neighbor_index, i64 noundef %k_prime_index, i64 noundef %k_prime) #0 !sec !{!"private", !"private", !{!"private", !"private", !"private", !"private", !"private", !"private"}} {
entry:                                            ; !sec !{!"private"}
  %root.addr = alloca ptr, align 8, !sec !{!"private"}
  %n.addr = alloca ptr, align 8, !sec !{!"private"}
  %neighbor.addr = alloca ptr, align 8, !sec !{!"private"}
  %neighbor_index.addr = alloca i64, align 8, !sec !{!"private"}
  %k_prime_index.addr = alloca i64, align 8, !sec !{!"private"}
  %k_prime.addr = alloca i64, align 8, !sec !{!"private"}
  %i = alloca i64, align 8, !sec !{!"private"}
  %tmp = alloca ptr, align 8, !sec !{!"private"}
  store ptr %root, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  store ptr %n, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  store ptr %neighbor, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  store i64 %neighbor_index, ptr %neighbor_index.addr, align 8, !sec !{!"private", !"private"}
  store i64 %k_prime_index, ptr %k_prime_index.addr, align 8, !sec !{!"private", !"private"}
  store i64 %k_prime, ptr %k_prime.addr, align 8, !sec !{!"private", !"private"}
  %0 = load i64, ptr %neighbor_index.addr, align 8, !sec !{!"private", !"private"}
  %cmp = icmp ne i64 %0, -1, !sec !{!"private"}
  br i1 %cmp, label %if.then, label %if.else59, !sec !{!"private"}

if.then:                                          ; preds = %entry, !sec !{!"private"}
  %1 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %is_leaf = getelementptr inbounds %struct.node, ptr %1, i32 0, i32 3, !sec !{!"private", !"private", !"public", !"public"}
  %2 = load i8, ptr %is_leaf, align 8, !sec !{!"private", !"private"}
  %tobool = trunc i8 %2 to i1, !sec !{!"private"}
  br i1 %tobool, label %if.end, label %if.then1, !sec !{!"private"}

if.then1:                                         ; preds = %if.then, !sec !{!"private"}
  %3 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %pointers = getelementptr inbounds %struct.node, ptr %3, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %4 = load ptr, ptr %pointers, align 8, !sec !{!"private", !"private"}
  %5 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %num_keys = getelementptr inbounds %struct.node, ptr %5, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %6 = load i64, ptr %num_keys, align 8, !sec !{!"private", !"private"}
  %arrayidx = getelementptr inbounds ptr, ptr %4, i64 %6, !sec !{!"private", !"private", !"private"}
  %7 = load ptr, ptr %arrayidx, align 8, !sec !{!"private", !"private"}
  %8 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %pointers2 = getelementptr inbounds %struct.node, ptr %8, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %9 = load ptr, ptr %pointers2, align 8, !sec !{!"private", !"private"}
  %10 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %num_keys3 = getelementptr inbounds %struct.node, ptr %10, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %11 = load i64, ptr %num_keys3, align 8, !sec !{!"private", !"private"}
  %add = add i64 %11, 1, !sec !{!"private"}
  %arrayidx4 = getelementptr inbounds ptr, ptr %9, i64 %add, !sec !{!"private", !"private", !"private"}
  store ptr %7, ptr %arrayidx4, align 8, !sec !{!"private", !"private"}
  br label %if.end, !sec !{!"public"}

if.end:                                           ; preds = %if.then1, %if.then, !sec !{!"private"}
  %12 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %num_keys5 = getelementptr inbounds %struct.node, ptr %12, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %13 = load i64, ptr %num_keys5, align 8, !sec !{!"private", !"private"}
  store i64 %13, ptr %i, align 8, !sec !{!"private", !"private"}
  br label %for.cond, !sec !{!"public"}

for.cond:                                         ; preds = %for.inc, %if.end, !sec !{!"private"}
  %14 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %cmp6 = icmp ugt i64 %14, 0, !sec !{!"private"}
  br i1 %cmp6, label %for.body, label %for.end, !sec !{!"private"}

for.body:                                         ; preds = %for.cond, !sec !{!"private"}
  %15 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %keys = getelementptr inbounds %struct.node, ptr %15, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %16 = load ptr, ptr %keys, align 8, !sec !{!"private", !"private"}
  %17 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %sub = sub i64 %17, 1, !sec !{!"private"}
  %arrayidx7 = getelementptr inbounds i64, ptr %16, i64 %sub, !sec !{!"private", !"private", !"private"}
  %18 = load i64, ptr %arrayidx7, align 8, !sec !{!"private", !"private"}
  %19 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %keys8 = getelementptr inbounds %struct.node, ptr %19, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %20 = load ptr, ptr %keys8, align 8, !sec !{!"private", !"private"}
  %21 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx9 = getelementptr inbounds i64, ptr %20, i64 %21, !sec !{!"private", !"private", !"private"}
  store i64 %18, ptr %arrayidx9, align 8, !sec !{!"private", !"private"}
  %22 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %pointers10 = getelementptr inbounds %struct.node, ptr %22, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %23 = load ptr, ptr %pointers10, align 8, !sec !{!"private", !"private"}
  %24 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %sub11 = sub i64 %24, 1, !sec !{!"private"}
  %arrayidx12 = getelementptr inbounds ptr, ptr %23, i64 %sub11, !sec !{!"private", !"private", !"private"}
  %25 = load ptr, ptr %arrayidx12, align 8, !sec !{!"private", !"private"}
  %26 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %pointers13 = getelementptr inbounds %struct.node, ptr %26, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %27 = load ptr, ptr %pointers13, align 8, !sec !{!"private", !"private"}
  %28 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx14 = getelementptr inbounds ptr, ptr %27, i64 %28, !sec !{!"private", !"private", !"private"}
  store ptr %25, ptr %arrayidx14, align 8, !sec !{!"private", !"private"}
  br label %for.inc, !sec !{!"public"}

for.inc:                                          ; preds = %for.body, !sec !{!"private"}
  %29 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %dec = add i64 %29, -1, !sec !{!"private"}
  store i64 %dec, ptr %i, align 8, !sec !{!"private", !"private"}
  br label %for.cond, !llvm.loop !49, !sec !{!"public"}

for.end:                                          ; preds = %for.cond, !sec !{!"private"}
  %30 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %is_leaf15 = getelementptr inbounds %struct.node, ptr %30, i32 0, i32 3, !sec !{!"private", !"private", !"public", !"public"}
  %31 = load i8, ptr %is_leaf15, align 8, !sec !{!"private", !"private"}
  %tobool16 = trunc i8 %31 to i1, !sec !{!"private"}
  br i1 %tobool16, label %if.else, label %if.then17, !sec !{!"private"}

if.then17:                                        ; preds = %for.end, !sec !{!"private"}
  %32 = load ptr, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  %pointers18 = getelementptr inbounds %struct.node, ptr %32, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %33 = load ptr, ptr %pointers18, align 8, !sec !{!"private", !"private"}
  %34 = load ptr, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  %num_keys19 = getelementptr inbounds %struct.node, ptr %34, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %35 = load i64, ptr %num_keys19, align 8, !sec !{!"private", !"private"}
  %arrayidx20 = getelementptr inbounds ptr, ptr %33, i64 %35, !sec !{!"private", !"private", !"private"}
  %36 = load ptr, ptr %arrayidx20, align 8, !sec !{!"private", !"private"}
  %37 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %pointers21 = getelementptr inbounds %struct.node, ptr %37, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %38 = load ptr, ptr %pointers21, align 8, !sec !{!"private", !"private"}
  %arrayidx22 = getelementptr inbounds ptr, ptr %38, i64 0, !sec !{!"private", !"private", !"public"}
  store ptr %36, ptr %arrayidx22, align 8, !sec !{!"private", !"private"}
  %39 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %pointers23 = getelementptr inbounds %struct.node, ptr %39, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %40 = load ptr, ptr %pointers23, align 8, !sec !{!"private", !"private"}
  %arrayidx24 = getelementptr inbounds ptr, ptr %40, i64 0, !sec !{!"private", !"private", !"public"}
  %41 = load ptr, ptr %arrayidx24, align 8, !sec !{!"private", !"private"}
  store ptr %41, ptr %tmp, align 8, !sec !{!"private", !"private"}
  %42 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %43 = load ptr, ptr %tmp, align 8, !sec !{!"private", !"private"}
  %parent = getelementptr inbounds %struct.node, ptr %43, i32 0, i32 2, !sec !{!"private", !"private", !"public", !"public"}
  store ptr %42, ptr %parent, align 8, !sec !{!"private", !"private"}
  %44 = load ptr, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  %pointers25 = getelementptr inbounds %struct.node, ptr %44, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %45 = load ptr, ptr %pointers25, align 8, !sec !{!"private", !"private"}
  %46 = load ptr, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  %num_keys26 = getelementptr inbounds %struct.node, ptr %46, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %47 = load i64, ptr %num_keys26, align 8, !sec !{!"private", !"private"}
  %arrayidx27 = getelementptr inbounds ptr, ptr %45, i64 %47, !sec !{!"private", !"private", !"private"}
  store ptr null, ptr %arrayidx27, align 8, !sec !{!"public", !"private"}
  %48 = load i64, ptr %k_prime.addr, align 8, !sec !{!"private", !"private"}
  %49 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %keys28 = getelementptr inbounds %struct.node, ptr %49, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %50 = load ptr, ptr %keys28, align 8, !sec !{!"private", !"private"}
  %arrayidx29 = getelementptr inbounds i64, ptr %50, i64 0, !sec !{!"private", !"private", !"public"}
  store i64 %48, ptr %arrayidx29, align 8, !sec !{!"private", !"private"}
  %51 = load ptr, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  %keys30 = getelementptr inbounds %struct.node, ptr %51, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %52 = load ptr, ptr %keys30, align 8, !sec !{!"private", !"private"}
  %53 = load ptr, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  %num_keys31 = getelementptr inbounds %struct.node, ptr %53, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %54 = load i64, ptr %num_keys31, align 8, !sec !{!"private", !"private"}
  %sub32 = sub i64 %54, 1, !sec !{!"private"}
  %arrayidx33 = getelementptr inbounds i64, ptr %52, i64 %sub32, !sec !{!"private", !"private", !"private"}
  %55 = load i64, ptr %arrayidx33, align 8, !sec !{!"private", !"private"}
  %56 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %parent34 = getelementptr inbounds %struct.node, ptr %56, i32 0, i32 2, !sec !{!"private", !"private", !"public", !"public"}
  %57 = load ptr, ptr %parent34, align 8, !sec !{!"private", !"private"}
  %keys35 = getelementptr inbounds %struct.node, ptr %57, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %58 = load ptr, ptr %keys35, align 8, !sec !{!"private", !"private"}
  %59 = load i64, ptr %k_prime_index.addr, align 8, !sec !{!"private", !"private"}
  %arrayidx36 = getelementptr inbounds i64, ptr %58, i64 %59, !sec !{!"private", !"private", !"private"}
  store i64 %55, ptr %arrayidx36, align 8, !sec !{!"private", !"private"}
  br label %if.end58, !sec !{!"public"}

if.else:                                          ; preds = %for.end, !sec !{!"private"}
  %60 = load ptr, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  %pointers37 = getelementptr inbounds %struct.node, ptr %60, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %61 = load ptr, ptr %pointers37, align 8, !sec !{!"private", !"private"}
  %62 = load ptr, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  %num_keys38 = getelementptr inbounds %struct.node, ptr %62, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %63 = load i64, ptr %num_keys38, align 8, !sec !{!"private", !"private"}
  %sub39 = sub i64 %63, 1, !sec !{!"private"}
  %arrayidx40 = getelementptr inbounds ptr, ptr %61, i64 %sub39, !sec !{!"private", !"private", !"private"}
  %64 = load ptr, ptr %arrayidx40, align 8, !sec !{!"private", !"private"}
  %65 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %pointers41 = getelementptr inbounds %struct.node, ptr %65, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %66 = load ptr, ptr %pointers41, align 8, !sec !{!"private", !"private"}
  %arrayidx42 = getelementptr inbounds ptr, ptr %66, i64 0, !sec !{!"private", !"private", !"public"}
  store ptr %64, ptr %arrayidx42, align 8, !sec !{!"private", !"private"}
  %67 = load ptr, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  %pointers43 = getelementptr inbounds %struct.node, ptr %67, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %68 = load ptr, ptr %pointers43, align 8, !sec !{!"private", !"private"}
  %69 = load ptr, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  %num_keys44 = getelementptr inbounds %struct.node, ptr %69, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %70 = load i64, ptr %num_keys44, align 8, !sec !{!"private", !"private"}
  %sub45 = sub i64 %70, 1, !sec !{!"private"}
  %arrayidx46 = getelementptr inbounds ptr, ptr %68, i64 %sub45, !sec !{!"private", !"private", !"private"}
  store ptr null, ptr %arrayidx46, align 8, !sec !{!"public", !"private"}
  %71 = load ptr, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  %keys47 = getelementptr inbounds %struct.node, ptr %71, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %72 = load ptr, ptr %keys47, align 8, !sec !{!"private", !"private"}
  %73 = load ptr, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  %num_keys48 = getelementptr inbounds %struct.node, ptr %73, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %74 = load i64, ptr %num_keys48, align 8, !sec !{!"private", !"private"}
  %sub49 = sub i64 %74, 1, !sec !{!"private"}
  %arrayidx50 = getelementptr inbounds i64, ptr %72, i64 %sub49, !sec !{!"private", !"private", !"private"}
  %75 = load i64, ptr %arrayidx50, align 8, !sec !{!"private", !"private"}
  %76 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %keys51 = getelementptr inbounds %struct.node, ptr %76, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %77 = load ptr, ptr %keys51, align 8, !sec !{!"private", !"private"}
  %arrayidx52 = getelementptr inbounds i64, ptr %77, i64 0, !sec !{!"private", !"private", !"public"}
  store i64 %75, ptr %arrayidx52, align 8, !sec !{!"private", !"private"}
  %78 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %keys53 = getelementptr inbounds %struct.node, ptr %78, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %79 = load ptr, ptr %keys53, align 8, !sec !{!"private", !"private"}
  %arrayidx54 = getelementptr inbounds i64, ptr %79, i64 0, !sec !{!"private", !"private", !"public"}
  %80 = load i64, ptr %arrayidx54, align 8, !sec !{!"private", !"private"}
  %81 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %parent55 = getelementptr inbounds %struct.node, ptr %81, i32 0, i32 2, !sec !{!"private", !"private", !"public", !"public"}
  %82 = load ptr, ptr %parent55, align 8, !sec !{!"private", !"private"}
  %keys56 = getelementptr inbounds %struct.node, ptr %82, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %83 = load ptr, ptr %keys56, align 8, !sec !{!"private", !"private"}
  %84 = load i64, ptr %k_prime_index.addr, align 8, !sec !{!"private", !"private"}
  %arrayidx57 = getelementptr inbounds i64, ptr %83, i64 %84, !sec !{!"private", !"private", !"private"}
  store i64 %80, ptr %arrayidx57, align 8, !sec !{!"private", !"private"}
  br label %if.end58, !sec !{!"public"}

if.end58:                                         ; preds = %if.else, %if.then17, !sec !{!"private"}
  br label %if.end125, !sec !{!"public"}

if.else59:                                        ; preds = %entry, !sec !{!"private"}
  %85 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %is_leaf60 = getelementptr inbounds %struct.node, ptr %85, i32 0, i32 3, !sec !{!"private", !"private", !"public", !"public"}
  %86 = load i8, ptr %is_leaf60, align 8, !sec !{!"private", !"private"}
  %tobool61 = trunc i8 %86 to i1, !sec !{!"private"}
  br i1 %tobool61, label %if.then62, label %if.else78, !sec !{!"private"}

if.then62:                                        ; preds = %if.else59, !sec !{!"private"}
  %87 = load ptr, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  %keys63 = getelementptr inbounds %struct.node, ptr %87, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %88 = load ptr, ptr %keys63, align 8, !sec !{!"private", !"private"}
  %arrayidx64 = getelementptr inbounds i64, ptr %88, i64 0, !sec !{!"private", !"private", !"public"}
  %89 = load i64, ptr %arrayidx64, align 8, !sec !{!"private", !"private"}
  %90 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %keys65 = getelementptr inbounds %struct.node, ptr %90, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %91 = load ptr, ptr %keys65, align 8, !sec !{!"private", !"private"}
  %92 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %num_keys66 = getelementptr inbounds %struct.node, ptr %92, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %93 = load i64, ptr %num_keys66, align 8, !sec !{!"private", !"private"}
  %arrayidx67 = getelementptr inbounds i64, ptr %91, i64 %93, !sec !{!"private", !"private", !"private"}
  store i64 %89, ptr %arrayidx67, align 8, !sec !{!"private", !"private"}
  %94 = load ptr, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  %pointers68 = getelementptr inbounds %struct.node, ptr %94, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %95 = load ptr, ptr %pointers68, align 8, !sec !{!"private", !"private"}
  %arrayidx69 = getelementptr inbounds ptr, ptr %95, i64 0, !sec !{!"private", !"private", !"public"}
  %96 = load ptr, ptr %arrayidx69, align 8, !sec !{!"private", !"private"}
  %97 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %pointers70 = getelementptr inbounds %struct.node, ptr %97, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %98 = load ptr, ptr %pointers70, align 8, !sec !{!"private", !"private"}
  %99 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %num_keys71 = getelementptr inbounds %struct.node, ptr %99, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %100 = load i64, ptr %num_keys71, align 8, !sec !{!"private", !"private"}
  %arrayidx72 = getelementptr inbounds ptr, ptr %98, i64 %100, !sec !{!"private", !"private", !"private"}
  store ptr %96, ptr %arrayidx72, align 8, !sec !{!"private", !"private"}
  %101 = load ptr, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  %keys73 = getelementptr inbounds %struct.node, ptr %101, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %102 = load ptr, ptr %keys73, align 8, !sec !{!"private", !"private"}
  %arrayidx74 = getelementptr inbounds i64, ptr %102, i64 1, !sec !{!"private", !"private", !"public"}
  %103 = load i64, ptr %arrayidx74, align 8, !sec !{!"private", !"private"}
  %104 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %parent75 = getelementptr inbounds %struct.node, ptr %104, i32 0, i32 2, !sec !{!"private", !"private", !"public", !"public"}
  %105 = load ptr, ptr %parent75, align 8, !sec !{!"private", !"private"}
  %keys76 = getelementptr inbounds %struct.node, ptr %105, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %106 = load ptr, ptr %keys76, align 8, !sec !{!"private", !"private"}
  %107 = load i64, ptr %k_prime_index.addr, align 8, !sec !{!"private", !"private"}
  %arrayidx77 = getelementptr inbounds i64, ptr %106, i64 %107, !sec !{!"private", !"private", !"private"}
  store i64 %103, ptr %arrayidx77, align 8, !sec !{!"private", !"private"}
  br label %if.end98, !sec !{!"public"}

if.else78:                                        ; preds = %if.else59, !sec !{!"private"}
  %108 = load i64, ptr %k_prime.addr, align 8, !sec !{!"private", !"private"}
  %109 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %keys79 = getelementptr inbounds %struct.node, ptr %109, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %110 = load ptr, ptr %keys79, align 8, !sec !{!"private", !"private"}
  %111 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %num_keys80 = getelementptr inbounds %struct.node, ptr %111, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %112 = load i64, ptr %num_keys80, align 8, !sec !{!"private", !"private"}
  %arrayidx81 = getelementptr inbounds i64, ptr %110, i64 %112, !sec !{!"private", !"private", !"private"}
  store i64 %108, ptr %arrayidx81, align 8, !sec !{!"private", !"private"}
  %113 = load ptr, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  %pointers82 = getelementptr inbounds %struct.node, ptr %113, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %114 = load ptr, ptr %pointers82, align 8, !sec !{!"private", !"private"}
  %arrayidx83 = getelementptr inbounds ptr, ptr %114, i64 0, !sec !{!"private", !"private", !"public"}
  %115 = load ptr, ptr %arrayidx83, align 8, !sec !{!"private", !"private"}
  %116 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %pointers84 = getelementptr inbounds %struct.node, ptr %116, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %117 = load ptr, ptr %pointers84, align 8, !sec !{!"private", !"private"}
  %118 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %num_keys85 = getelementptr inbounds %struct.node, ptr %118, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %119 = load i64, ptr %num_keys85, align 8, !sec !{!"private", !"private"}
  %add86 = add i64 %119, 1, !sec !{!"private"}
  %arrayidx87 = getelementptr inbounds ptr, ptr %117, i64 %add86, !sec !{!"private", !"private", !"private"}
  store ptr %115, ptr %arrayidx87, align 8, !sec !{!"private", !"private"}
  %120 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %pointers88 = getelementptr inbounds %struct.node, ptr %120, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %121 = load ptr, ptr %pointers88, align 8, !sec !{!"private", !"private"}
  %122 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %num_keys89 = getelementptr inbounds %struct.node, ptr %122, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %123 = load i64, ptr %num_keys89, align 8, !sec !{!"private", !"private"}
  %add90 = add i64 %123, 1, !sec !{!"private"}
  %arrayidx91 = getelementptr inbounds ptr, ptr %121, i64 %add90, !sec !{!"private", !"private", !"private"}
  %124 = load ptr, ptr %arrayidx91, align 8, !sec !{!"private", !"private"}
  store ptr %124, ptr %tmp, align 8, !sec !{!"private", !"private"}
  %125 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %126 = load ptr, ptr %tmp, align 8, !sec !{!"private", !"private"}
  %parent92 = getelementptr inbounds %struct.node, ptr %126, i32 0, i32 2, !sec !{!"private", !"private", !"public", !"public"}
  store ptr %125, ptr %parent92, align 8, !sec !{!"private", !"private"}
  %127 = load ptr, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  %keys93 = getelementptr inbounds %struct.node, ptr %127, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %128 = load ptr, ptr %keys93, align 8, !sec !{!"private", !"private"}
  %arrayidx94 = getelementptr inbounds i64, ptr %128, i64 0, !sec !{!"private", !"private", !"public"}
  %129 = load i64, ptr %arrayidx94, align 8, !sec !{!"private", !"private"}
  %130 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %parent95 = getelementptr inbounds %struct.node, ptr %130, i32 0, i32 2, !sec !{!"private", !"private", !"public", !"public"}
  %131 = load ptr, ptr %parent95, align 8, !sec !{!"private", !"private"}
  %keys96 = getelementptr inbounds %struct.node, ptr %131, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %132 = load ptr, ptr %keys96, align 8, !sec !{!"private", !"private"}
  %133 = load i64, ptr %k_prime_index.addr, align 8, !sec !{!"private", !"private"}
  %arrayidx97 = getelementptr inbounds i64, ptr %132, i64 %133, !sec !{!"private", !"private", !"private"}
  store i64 %129, ptr %arrayidx97, align 8, !sec !{!"private", !"private"}
  br label %if.end98, !sec !{!"public"}

if.end98:                                         ; preds = %if.else78, %if.then62, !sec !{!"private"}
  store i64 0, ptr %i, align 8, !sec !{!"public", !"private"}
  br label %for.cond99, !sec !{!"public"}

for.cond99:                                       ; preds = %for.inc114, %if.end98, !sec !{!"private"}
  %134 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %135 = load ptr, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  %num_keys100 = getelementptr inbounds %struct.node, ptr %135, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %136 = load i64, ptr %num_keys100, align 8, !sec !{!"private", !"private"}
  %sub101 = sub i64 %136, 1, !sec !{!"private"}
  %cmp102 = icmp ult i64 %134, %sub101, !sec !{!"private"}
  br i1 %cmp102, label %for.body103, label %for.end115, !sec !{!"private"}

for.body103:                                      ; preds = %for.cond99, !sec !{!"private"}
  %137 = load ptr, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  %keys104 = getelementptr inbounds %struct.node, ptr %137, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %138 = load ptr, ptr %keys104, align 8, !sec !{!"private", !"private"}
  %139 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %add105 = add i64 %139, 1, !sec !{!"private"}
  %arrayidx106 = getelementptr inbounds i64, ptr %138, i64 %add105, !sec !{!"private", !"private", !"private"}
  %140 = load i64, ptr %arrayidx106, align 8, !sec !{!"private", !"private"}
  %141 = load ptr, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  %keys107 = getelementptr inbounds %struct.node, ptr %141, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %142 = load ptr, ptr %keys107, align 8, !sec !{!"private", !"private"}
  %143 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx108 = getelementptr inbounds i64, ptr %142, i64 %143, !sec !{!"private", !"private", !"private"}
  store i64 %140, ptr %arrayidx108, align 8, !sec !{!"private", !"private"}
  %144 = load ptr, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  %pointers109 = getelementptr inbounds %struct.node, ptr %144, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %145 = load ptr, ptr %pointers109, align 8, !sec !{!"private", !"private"}
  %146 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %add110 = add i64 %146, 1, !sec !{!"private"}
  %arrayidx111 = getelementptr inbounds ptr, ptr %145, i64 %add110, !sec !{!"private", !"private", !"private"}
  %147 = load ptr, ptr %arrayidx111, align 8, !sec !{!"private", !"private"}
  %148 = load ptr, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  %pointers112 = getelementptr inbounds %struct.node, ptr %148, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %149 = load ptr, ptr %pointers112, align 8, !sec !{!"private", !"private"}
  %150 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx113 = getelementptr inbounds ptr, ptr %149, i64 %150, !sec !{!"private", !"private", !"private"}
  store ptr %147, ptr %arrayidx113, align 8, !sec !{!"private", !"private"}
  br label %for.inc114, !sec !{!"public"}

for.inc114:                                       ; preds = %for.body103, !sec !{!"private"}
  %151 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %inc = add i64 %151, 1, !sec !{!"private"}
  store i64 %inc, ptr %i, align 8, !sec !{!"private", !"private"}
  br label %for.cond99, !llvm.loop !50, !sec !{!"public"}

for.end115:                                       ; preds = %for.cond99, !sec !{!"private"}
  %152 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %is_leaf116 = getelementptr inbounds %struct.node, ptr %152, i32 0, i32 3, !sec !{!"private", !"private", !"public", !"public"}
  %153 = load i8, ptr %is_leaf116, align 8, !sec !{!"private", !"private"}
  %tobool117 = trunc i8 %153 to i1, !sec !{!"private"}
  br i1 %tobool117, label %if.end124, label %if.then118, !sec !{!"private"}

if.then118:                                       ; preds = %for.end115, !sec !{!"private"}
  %154 = load ptr, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  %pointers119 = getelementptr inbounds %struct.node, ptr %154, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %155 = load ptr, ptr %pointers119, align 8, !sec !{!"private", !"private"}
  %156 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %add120 = add i64 %156, 1, !sec !{!"private"}
  %arrayidx121 = getelementptr inbounds ptr, ptr %155, i64 %add120, !sec !{!"private", !"private", !"private"}
  %157 = load ptr, ptr %arrayidx121, align 8, !sec !{!"private", !"private"}
  %158 = load ptr, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  %pointers122 = getelementptr inbounds %struct.node, ptr %158, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %159 = load ptr, ptr %pointers122, align 8, !sec !{!"private", !"private"}
  %160 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx123 = getelementptr inbounds ptr, ptr %159, i64 %160, !sec !{!"private", !"private", !"private"}
  store ptr %157, ptr %arrayidx123, align 8, !sec !{!"private", !"private"}
  br label %if.end124, !sec !{!"public"}

if.end124:                                        ; preds = %if.then118, %for.end115, !sec !{!"private"}
  br label %if.end125, !sec !{!"public"}

if.end125:                                        ; preds = %if.end124, %if.end58, !sec !{!"private"}
  %161 = load ptr, ptr %n.addr, align 8, !sec !{!"private", !"private"}
  %num_keys126 = getelementptr inbounds %struct.node, ptr %161, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %162 = load i64, ptr %num_keys126, align 8, !sec !{!"private", !"private"}
  %inc127 = add i64 %162, 1, !sec !{!"private"}
  store i64 %inc127, ptr %num_keys126, align 8, !sec !{!"private", !"private"}
  %163 = load ptr, ptr %neighbor.addr, align 8, !sec !{!"private", !"private"}
  %num_keys128 = getelementptr inbounds %struct.node, ptr %163, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %164 = load i64, ptr %num_keys128, align 8, !sec !{!"private", !"private"}
  %dec129 = add i64 %164, -1, !sec !{!"private"}
  store i64 %dec129, ptr %num_keys128, align 8, !sec !{!"private", !"private"}
  %165 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  ret ptr %165, !sec !{!"private"}
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @delete(ptr noundef %root, i64 noundef %key) #0 !sec !{!"private", !"private", !{!"private", !"private"}} {
entry:                                            ; !sec !{!"private"}
  %root.addr = alloca ptr, align 8, !sec !{!"private"}
  %key.addr = alloca i64, align 8, !sec !{!"private"}
  %key_leaf = alloca ptr, align 8, !sec !{!"private"}
  %key_record = alloca ptr, align 8, !sec !{!"private"}
  store ptr %root, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  store i64 %key, ptr %key.addr, align 8, !sec !{!"private", !"private"}
  store ptr null, ptr %key_leaf, align 8, !sec !{!"public", !"private"}
  store ptr null, ptr %key_record, align 8, !sec !{!"public", !"private"}
  %0 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %1 = load i64, ptr %key.addr, align 8, !sec !{!"private", !"private"}
  %call = call ptr @find(ptr noundef %0, i64 noundef %1, ptr noundef %key_leaf), !sec !{!"call", !"private", !{!"private", !"private", !"private"}}
  store ptr %call, ptr %key_record, align 8, !sec !{!"private", !"private"}
  %2 = load ptr, ptr %key_record, align 8, !sec !{!"private", !"private"}
  %cmp = icmp ne ptr %2, null, !sec !{!"private"}
  br i1 %cmp, label %land.lhs.true, label %if.end, !sec !{!"private"}

land.lhs.true:                                    ; preds = %entry, !sec !{!"private"}
  %3 = load ptr, ptr %key_leaf, align 8, !sec !{!"private", !"private"}
  %cmp1 = icmp ne ptr %3, null, !sec !{!"private"}
  br i1 %cmp1, label %if.then, label %if.end, !sec !{!"private"}

if.then:                                          ; preds = %land.lhs.true, !sec !{!"private"}
  %4 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %5 = load ptr, ptr %key_leaf, align 8, !sec !{!"private", !"private"}
  %6 = load i64, ptr %key.addr, align 8, !sec !{!"private", !"private"}
  %7 = load ptr, ptr %key_record, align 8, !sec !{!"private", !"private"}
  %call2 = call ptr @delete_entry(ptr noundef %4, ptr noundef %5, i64 noundef %6, ptr noundef %7), !sec !{!"call", !"private", !{!"private", !"private", !"private", !"private"}}
  store ptr %call2, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %8 = load ptr, ptr %key_record, align 8, !sec !{!"private", !"private"}
  call void @free_record(ptr noundef %8), !sec !{!"call", !"void", !{!"private"}}
  br label %if.end, !sec !{!"public"}

if.end:                                           ; preds = %if.then, %land.lhs.true, %entry, !sec !{!"private"}
  %9 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  ret ptr %9, !sec !{!"private"}
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @destroy_tree_nodes(ptr noundef %root) #0 !sec !{!"void", !"private", !{!"private"}} {
entry:                                            ; !sec !{!"private"}
  %root.addr = alloca ptr, align 8, !sec !{!"private"}
  %i = alloca i64, align 8, !sec !{!"private"}
  store ptr %root, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %0 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %is_leaf = getelementptr inbounds %struct.node, ptr %0, i32 0, i32 3, !sec !{!"private", !"private", !"public", !"public"}
  %1 = load i8, ptr %is_leaf, align 8, !sec !{!"private", !"private"}
  %tobool = trunc i8 %1 to i1, !sec !{!"private"}
  br i1 %tobool, label %if.then, label %if.else, !sec !{!"private"}

if.then:                                          ; preds = %entry, !sec !{!"private"}
  store i64 0, ptr %i, align 8, !sec !{!"public", !"private"}
  br label %for.cond, !sec !{!"public"}

for.cond:                                         ; preds = %for.inc, %if.then, !sec !{!"private"}
  %2 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %3 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %num_keys = getelementptr inbounds %struct.node, ptr %3, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %4 = load i64, ptr %num_keys, align 8, !sec !{!"private", !"private"}
  %cmp = icmp ult i64 %2, %4, !sec !{!"private"}
  br i1 %cmp, label %for.body, label %for.end, !sec !{!"private"}

for.body:                                         ; preds = %for.cond, !sec !{!"private"}
  %5 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %pointers = getelementptr inbounds %struct.node, ptr %5, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %6 = load ptr, ptr %pointers, align 8, !sec !{!"private", !"private"}
  %7 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx = getelementptr inbounds ptr, ptr %6, i64 %7, !sec !{!"private", !"private", !"private"}
  %8 = load ptr, ptr %arrayidx, align 8, !sec !{!"private", !"private"}
  call void @free(ptr noundef %8) #8, !sec !{!"public"}
  br label %for.inc, !sec !{!"public"}

for.inc:                                          ; preds = %for.body, !sec !{!"private"}
  %9 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %inc = add i64 %9, 1, !sec !{!"private"}
  store i64 %inc, ptr %i, align 8, !sec !{!"private", !"private"}
  br label %for.cond, !llvm.loop !51, !sec !{!"public"}

for.end:                                          ; preds = %for.cond, !sec !{!"private"}
  br label %if.end, !sec !{!"public"}

if.else:                                          ; preds = %entry, !sec !{!"private"}
  store i64 0, ptr %i, align 8, !sec !{!"public", !"private"}
  br label %for.cond1, !sec !{!"public"}

for.cond1:                                        ; preds = %for.inc7, %if.else, !sec !{!"private"}
  %10 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %11 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %num_keys2 = getelementptr inbounds %struct.node, ptr %11, i32 0, i32 4, !sec !{!"private", !"private", !"public", !"public"}
  %12 = load i64, ptr %num_keys2, align 8, !sec !{!"private", !"private"}
  %add = add i64 %12, 1, !sec !{!"private"}
  %cmp3 = icmp ult i64 %10, %add, !sec !{!"private"}
  br i1 %cmp3, label %for.body4, label %for.end9, !sec !{!"private"}

for.body4:                                        ; preds = %for.cond1, !sec !{!"private"}
  %13 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %pointers5 = getelementptr inbounds %struct.node, ptr %13, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %14 = load ptr, ptr %pointers5, align 8, !sec !{!"private", !"private"}
  %15 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %arrayidx6 = getelementptr inbounds ptr, ptr %14, i64 %15, !sec !{!"private", !"private", !"private"}
  %16 = load ptr, ptr %arrayidx6, align 8, !sec !{!"private", !"private"}
  call void @destroy_tree_nodes(ptr noundef %16), !sec !{!"call", !"void", !{!"private"}}
  br label %for.inc7, !sec !{!"public"}

for.inc7:                                         ; preds = %for.body4, !sec !{!"private"}
  %17 = load i64, ptr %i, align 8, !sec !{!"private", !"private"}
  %inc8 = add i64 %17, 1, !sec !{!"private"}
  store i64 %inc8, ptr %i, align 8, !sec !{!"private", !"private"}
  br label %for.cond1, !llvm.loop !52, !sec !{!"public"}

for.end9:                                         ; preds = %for.cond1, !sec !{!"private"}
  br label %if.end, !sec !{!"public"}

if.end:                                           ; preds = %for.end9, %for.end, !sec !{!"private"}
  %18 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %pointers10 = getelementptr inbounds %struct.node, ptr %18, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %19 = load ptr, ptr %pointers10, align 8, !sec !{!"private", !"private"}
  call void @free(ptr noundef %19) #8, !sec !{!"public"}
  %20 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %keys = getelementptr inbounds %struct.node, ptr %20, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  %21 = load ptr, ptr %keys, align 8, !sec !{!"private", !"private"}
  call void @free(ptr noundef %21) #8, !sec !{!"public"}
  %22 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  call void @free_node(ptr noundef %22), !sec !{!"call", !"void", !{!"private"}}
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @destroy_tree(ptr noundef %root) #0 !sec !{!"private", !"private", !{!"private"}} {
entry:                                            ; !sec !{!"private"}
  %root.addr = alloca ptr, align 8, !sec !{!"private"}
  store ptr %root, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  %0 = load ptr, ptr %root.addr, align 8, !sec !{!"private", !"private"}
  call void @destroy_tree_nodes(ptr noundef %0), !sec !{!"call", !"void", !{!"private"}}
  ret ptr null, !sec !{!"private"}
}

; Function Attrs: noinline nounwind optnone uwtable
;? myrand
;? Purpose: Generate random number from RNG state
;?
;? Return value analysis:
;?   - Type: i64
;?   - Semantic meaning: Random number
;?   - Data it holds: Random value derived from private RNG state (@x)
;?   - Security label: private
;?   - Rationale: Loads from private global @x, so returns private value
;?
;? Parameters: none
;?
;? Min-PC: private
;? Rationale: Calls next() which modifies private RNG state, and operates on private @x
define dso_local i64 @myrand() #0 !sec !{!"private", !"private", !{}} {
entry:                                            ; !sec !{!"private"}
  call void @next(), !sec !{!"call", !"void", !{}}
  %0 = load i64, ptr getelementptr inbounds ([3 x i64], ptr @x, i64 0, i64 2), align 16, !sec !{!"private", !"private"}
  %shl = shl i64 %0, 15, !sec !{!"private"}
  %1 = load i64, ptr getelementptr inbounds ([3 x i64], ptr @x, i64 0, i64 1), align 8, !sec !{!"private", !"private"}
  %shr = lshr i64 %1, 1, !sec !{!"private"}
  %add = add i64 %shl, %shr, !sec !{!"private"}
  ret i64 %add, !sec !{!"private"}
}

;? next
;? Purpose: Advance RNG state to next value
;?
;? Return value: void
;?
;? Parameters: none
;?
;? Min-PC: private
;? Rationale: Modifies private RNG state (@x, @a, @c)
; Function Attrs: noinline nounwind optnone uwtable
define internal void @next() #0 !sec !{!"void", !"private", !{}} {
entry:                                            ; !sec !{!"private"}
  %p = alloca [2 x i64], align 16, !sec !{!"private"}
  %q = alloca [2 x i64], align 16, !sec !{!"private"}
  %r = alloca [2 x i64], align 16, !sec !{!"private"}
  %carry0 = alloca i64, align 8, !sec !{!"private"}
  %carry1 = alloca i64, align 8, !sec !{!"private"}
  %l = alloca i32, align 4, !sec !{!"private"}
  %l29 = alloca i32, align 4, !sec !{!"private"}
  %l54 = alloca i32, align 4, !sec !{!"private"}
  %0 = load i64, ptr @a, align 16, !sec !{!"private", !"private"}
  %1 = load i64, ptr @x, align 16, !sec !{!"private", !"private"}
  %mul = mul nsw i64 %0, %1, !sec !{!"private"}
  %conv = trunc i64 %mul to i32, !sec !{!"private"}
  store i32 %conv, ptr %l, align 4, !sec !{!"private", !"private"}
  %2 = load i32, ptr %l, align 4, !sec !{!"private", !"private"}
  %and = and i32 %2, 65535, !sec !{!"private"}
  %conv1 = zext i32 %and to i64, !sec !{!"private"}
  %arrayidx = getelementptr inbounds [2 x i64], ptr %p, i64 0, i64 0, !sec !{!"private", !"private", !"public", !"public"}
  store i64 %conv1, ptr %arrayidx, align 16, !sec !{!"private", !"private"}
  %3 = load i32, ptr %l, align 4, !sec !{!"private", !"private"}
  %shr = ashr i32 %3, 16, !sec !{!"private"}
  %and2 = and i32 %shr, 65535, !sec !{!"private"}
  %conv3 = zext i32 %and2 to i64, !sec !{!"private"}
  %arrayidx4 = getelementptr inbounds [2 x i64], ptr %p, i64 0, i64 1, !sec !{!"private", !"private", !"public", !"public"}
  store i64 %conv3, ptr %arrayidx4, align 8, !sec !{!"private", !"private"}
  %arrayidx5 = getelementptr inbounds [2 x i64], ptr %p, i64 0, i64 0, !sec !{!"private", !"private", !"public", !"public"}
  %4 = load i64, ptr %arrayidx5, align 16, !sec !{!"private", !"private"}
  %conv6 = trunc i64 %4 to i32, !sec !{!"private"}
  %conv7 = sext i32 %conv6 to i64, !sec !{!"private"}
  %5 = load i64, ptr @c, align 8, !sec !{!"private", !"private"}
  %add = add nsw i64 %conv7, %5, !sec !{!"private"}
  %cmp = icmp sgt i64 %add, 65535, !sec !{!"private"}
  %conv8 = zext i1 %cmp to i32, !sec !{!"private"}
  %conv9 = sext i32 %conv8 to i64, !sec !{!"private"}
  store i64 %conv9, ptr %carry0, align 8, !sec !{!"private", !"private"}
  %arrayidx10 = getelementptr inbounds [2 x i64], ptr %p, i64 0, i64 0, !sec !{!"private", !"private", !"public", !"public"}
  %6 = load i64, ptr %arrayidx10, align 16, !sec !{!"private", !"private"}
  %7 = load i64, ptr @c, align 8, !sec !{!"private", !"private"}
  %add11 = add i64 %6, %7, !sec !{!"private"}
  %conv12 = trunc i64 %add11 to i32, !sec !{!"private"}
  %and13 = and i32 %conv12, 65535, !sec !{!"private"}
  %conv14 = zext i32 %and13 to i64, !sec !{!"private"}
  %arrayidx15 = getelementptr inbounds [2 x i64], ptr %p, i64 0, i64 0, !sec !{!"private", !"private", !"public", !"public"}
  store i64 %conv14, ptr %arrayidx15, align 16, !sec !{!"private", !"private"}
  %arrayidx16 = getelementptr inbounds [2 x i64], ptr %p, i64 0, i64 1, !sec !{!"private", !"private", !"public", !"public"}
  %8 = load i64, ptr %arrayidx16, align 8, !sec !{!"private", !"private"}
  %conv17 = trunc i64 %8 to i32, !sec !{!"private"}
  %conv18 = sext i32 %conv17 to i64, !sec !{!"private"}
  %9 = load i64, ptr %carry0, align 8, !sec !{!"private", !"private"}
  %add19 = add nsw i64 %conv18, %9, !sec !{!"private"}
  %cmp20 = icmp sgt i64 %add19, 65535, !sec !{!"private"}
  %conv21 = zext i1 %cmp20 to i32, !sec !{!"private"}
  %conv22 = sext i32 %conv21 to i64, !sec !{!"private"}
  store i64 %conv22, ptr %carry1, align 8, !sec !{!"private", !"private"}
  %arrayidx23 = getelementptr inbounds [2 x i64], ptr %p, i64 0, i64 1, !sec !{!"private", !"private", !"public", !"public"}
  %10 = load i64, ptr %arrayidx23, align 8, !sec !{!"private", !"private"}
  %11 = load i64, ptr %carry0, align 8, !sec !{!"private", !"private"}
  %add24 = add i64 %10, %11, !sec !{!"private"}
  %conv25 = trunc i64 %add24 to i32, !sec !{!"private"}
  %and26 = and i32 %conv25, 65535, !sec !{!"private"}
  %conv27 = zext i32 %and26 to i64, !sec !{!"private"}
  %arrayidx28 = getelementptr inbounds [2 x i64], ptr %p, i64 0, i64 1, !sec !{!"private", !"private", !"public", !"public"}
  store i64 %conv27, ptr %arrayidx28, align 8, !sec !{!"private", !"private"}
  %12 = load i64, ptr @a, align 16, !sec !{!"private", !"private"}
  %13 = load i64, ptr getelementptr inbounds ([3 x i64], ptr @x, i64 0, i64 1), align 8, !sec !{!"private", !"private"}
  %mul30 = mul nsw i64 %12, %13, !sec !{!"private"}
  %conv31 = trunc i64 %mul30 to i32, !sec !{!"private"}
  store i32 %conv31, ptr %l29, align 4, !sec !{!"private", !"private"}
  %14 = load i32, ptr %l29, align 4, !sec !{!"private", !"private"}
  %and32 = and i32 %14, 65535, !sec !{!"private"}
  %conv33 = zext i32 %and32 to i64, !sec !{!"private"}
  %arrayidx34 = getelementptr inbounds [2 x i64], ptr %q, i64 0, i64 0, !sec !{!"private", !"private", !"public", !"public"}
  store i64 %conv33, ptr %arrayidx34, align 16, !sec !{!"private", !"private"}
  %15 = load i32, ptr %l29, align 4, !sec !{!"private", !"private"}
  %shr35 = ashr i32 %15, 16, !sec !{!"private"}
  %and36 = and i32 %shr35, 65535, !sec !{!"private"}
  %conv37 = zext i32 %and36 to i64, !sec !{!"private"}
  %arrayidx38 = getelementptr inbounds [2 x i64], ptr %q, i64 0, i64 1, !sec !{!"private", !"private", !"public", !"public"}
  store i64 %conv37, ptr %arrayidx38, align 8, !sec !{!"private", !"private"}
  %arrayidx39 = getelementptr inbounds [2 x i64], ptr %p, i64 0, i64 1, !sec !{!"private", !"private", !"public", !"public"}
  %16 = load i64, ptr %arrayidx39, align 8, !sec !{!"private", !"private"}
  %conv40 = trunc i64 %16 to i32, !sec !{!"private"}
  %conv41 = sext i32 %conv40 to i64, !sec !{!"private"}
  %arrayidx42 = getelementptr inbounds [2 x i64], ptr %q, i64 0, i64 0, !sec !{!"private", !"private", !"public", !"public"}
  %17 = load i64, ptr %arrayidx42, align 16, !sec !{!"private", !"private"}
  %add43 = add nsw i64 %conv41, %17, !sec !{!"private"}
  %cmp44 = icmp sgt i64 %add43, 65535, !sec !{!"private"}
  %conv45 = zext i1 %cmp44 to i32, !sec !{!"private"}
  %conv46 = sext i32 %conv45 to i64, !sec !{!"private"}
  store i64 %conv46, ptr %carry0, align 8, !sec !{!"private", !"private"}
  %arrayidx47 = getelementptr inbounds [2 x i64], ptr %p, i64 0, i64 1, !sec !{!"private", !"private", !"public", !"public"}
  %18 = load i64, ptr %arrayidx47, align 8, !sec !{!"private", !"private"}
  %arrayidx48 = getelementptr inbounds [2 x i64], ptr %q, i64 0, i64 0, !sec !{!"private", !"private", !"public", !"public"}
  %19 = load i64, ptr %arrayidx48, align 16, !sec !{!"private", !"private"}
  %add49 = add i64 %18, %19, !sec !{!"private"}
  %conv50 = trunc i64 %add49 to i32, !sec !{!"private"}
  %and51 = and i32 %conv50, 65535, !sec !{!"private"}
  %conv52 = zext i32 %and51 to i64, !sec !{!"private"}
  %arrayidx53 = getelementptr inbounds [2 x i64], ptr %p, i64 0, i64 1, !sec !{!"private", !"private", !"public", !"public"}
  store i64 %conv52, ptr %arrayidx53, align 8, !sec !{!"private", !"private"}
  %20 = load i64, ptr getelementptr inbounds ([3 x i64], ptr @a, i64 0, i64 1), align 8, !sec !{!"private", !"private"}
  %21 = load i64, ptr @x, align 16, !sec !{!"private", !"private"}
  %mul55 = mul nsw i64 %20, %21, !sec !{!"private"}
  %conv56 = trunc i64 %mul55 to i32, !sec !{!"private"}
  store i32 %conv56, ptr %l54, align 4, !sec !{!"private", !"private"}
  %22 = load i32, ptr %l54, align 4, !sec !{!"private", !"private"}
  %and57 = and i32 %22, 65535, !sec !{!"private"}
  %conv58 = zext i32 %and57 to i64, !sec !{!"private"}
  %arrayidx59 = getelementptr inbounds [2 x i64], ptr %r, i64 0, i64 0, !sec !{!"private", !"private", !"public", !"public"}
  store i64 %conv58, ptr %arrayidx59, align 16, !sec !{!"private", !"private"}
  %23 = load i32, ptr %l54, align 4, !sec !{!"private", !"private"}
  %shr60 = ashr i32 %23, 16, !sec !{!"private"}
  %and61 = and i32 %shr60, 65535, !sec !{!"private"}
  %conv62 = zext i32 %and61 to i64, !sec !{!"private"}
  %arrayidx63 = getelementptr inbounds [2 x i64], ptr %r, i64 0, i64 1, !sec !{!"private", !"private", !"public", !"public"}
  store i64 %conv62, ptr %arrayidx63, align 8, !sec !{!"private", !"private"}
  %24 = load i64, ptr %carry0, align 8, !sec !{!"private", !"private"}
  %25 = load i64, ptr %carry1, align 8, !sec !{!"private", !"private"}
  %add64 = add i64 %24, %25, !sec !{!"private"}
  %arrayidx65 = getelementptr inbounds [2 x i64], ptr %p, i64 0, i64 1, !sec !{!"private", !"private", !"public", !"public"}
  %26 = load i64, ptr %arrayidx65, align 8, !sec !{!"private", !"private"}
  %conv66 = trunc i64 %26 to i32, !sec !{!"private"}
  %conv67 = sext i32 %conv66 to i64, !sec !{!"private"}
  %arrayidx68 = getelementptr inbounds [2 x i64], ptr %r, i64 0, i64 0, !sec !{!"private", !"private", !"public", !"public"}
  %27 = load i64, ptr %arrayidx68, align 16, !sec !{!"private", !"private"}
  %add69 = add nsw i64 %conv67, %27, !sec !{!"private"}
  %cmp70 = icmp sgt i64 %add69, 65535, !sec !{!"private"}
  %conv71 = zext i1 %cmp70 to i32, !sec !{!"private"}
  %conv72 = sext i32 %conv71 to i64, !sec !{!"private"}
  %add73 = add i64 %add64, %conv72, !sec !{!"private"}
  %arrayidx74 = getelementptr inbounds [2 x i64], ptr %q, i64 0, i64 1, !sec !{!"private", !"private", !"public", !"public"}
  %28 = load i64, ptr %arrayidx74, align 8, !sec !{!"private", !"private"}
  %add75 = add i64 %add73, %28, !sec !{!"private"}
  %arrayidx76 = getelementptr inbounds [2 x i64], ptr %r, i64 0, i64 1, !sec !{!"private", !"private", !"public", !"public"}
  %29 = load i64, ptr %arrayidx76, align 8, !sec !{!"private", !"private"}
  %add77 = add i64 %add75, %29, !sec !{!"private"}
  %30 = load i64, ptr @a, align 16, !sec !{!"private", !"private"}
  %31 = load i64, ptr getelementptr inbounds ([3 x i64], ptr @x, i64 0, i64 2), align 16, !sec !{!"private", !"private"}
  %mul78 = mul i64 %30, %31, !sec !{!"private"}
  %add79 = add i64 %add77, %mul78, !sec !{!"private"}
  %32 = load i64, ptr getelementptr inbounds ([3 x i64], ptr @a, i64 0, i64 1), align 8, !sec !{!"private", !"private"}
  %33 = load i64, ptr getelementptr inbounds ([3 x i64], ptr @x, i64 0, i64 1), align 8, !sec !{!"private", !"private"}
  %mul80 = mul i64 %32, %33, !sec !{!"private"}
  %add81 = add i64 %add79, %mul80, !sec !{!"private"}
  %34 = load i64, ptr getelementptr inbounds ([3 x i64], ptr @a, i64 0, i64 2), align 16, !sec !{!"private", !"private"}
  %35 = load i64, ptr @x, align 16, !sec !{!"private", !"private"}
  %mul82 = mul i64 %34, %35, !sec !{!"private"}
  %add83 = add i64 %add81, %mul82, !sec !{!"private"}
  %conv84 = trunc i64 %add83 to i32, !sec !{!"private"}
  %and85 = and i32 %conv84, 65535, !sec !{!"private"}
  %conv86 = zext i32 %and85 to i64, !sec !{!"private"}
  store i64 %conv86, ptr getelementptr inbounds ([3 x i64], ptr @x, i64 0, i64 2), align 16, !sec !{!"private", !"private", !"private", !"private", !"private"}
  %arrayidx87 = getelementptr inbounds [2 x i64], ptr %p, i64 0, i64 1, !sec !{!"private", !"private", !"public", !"public"}
  %36 = load i64, ptr %arrayidx87, align 8, !sec !{!"private", !"private"}
  %arrayidx88 = getelementptr inbounds [2 x i64], ptr %r, i64 0, i64 0, !sec !{!"private", !"private", !"public", !"public"}
  %37 = load i64, ptr %arrayidx88, align 16, !sec !{!"private", !"private"}
  %add89 = add i64 %36, %37, !sec !{!"private"}
  %conv90 = trunc i64 %add89 to i32, !sec !{!"private"}
  %and91 = and i32 %conv90, 65535, !sec !{!"private"}
  %conv92 = zext i32 %and91 to i64, !sec !{!"private"}
  store i64 %conv92, ptr getelementptr inbounds ([3 x i64], ptr @x, i64 0, i64 1), align 8, !sec !{!"private", !"private", !"private", !"private", !"private"}
  %arrayidx93 = getelementptr inbounds [2 x i64], ptr %p, i64 0, i64 0, !sec !{!"private", !"private", !"public", !"public"}
  %38 = load i64, ptr %arrayidx93, align 16, !sec !{!"private", !"private"}
  %conv94 = trunc i64 %38 to i32, !sec !{!"private"}
  %and95 = and i32 %conv94, 65535, !sec !{!"private"}
  %conv96 = zext i32 %and95 to i64, !sec !{!"private"}
  store i64 %conv96, ptr @x, align 16, !sec !{!"private", !"private"}
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
;? myrandseed
;? Purpose: Seed the random number generator
;?
;? Return value: void
;?
;? Parameter 1 (seedval):
;?   - Type: i32
;?   - Semantic meaning: Seed value for RNG
;?   - Usage in function: Used to initialize global RNG state (@x, @a, @c)
;?   - Data it holds: Seed value (could be private if called from private context)
;?   - Security label: public
;?   - Rationale: The seed value itself can be public.
;?
;? Min-PC: public
;? Rationale: This function modifies global RNG state, but it doesn't need to be callable from
;? private contexts.
define dso_local void @myrandseed(i32 noundef %seedval) #0 !sec !{!"void", !"public", !{!"public"}} {
entry:                                            ; !sec !{!"public"}
  %seedval.addr = alloca i32, align 4, !sec !{!"public"}
  store i32 %seedval, ptr %seedval.addr, align 4, !sec !{!"public", !"public"}
  store i64 13070, ptr @x, align 16, !sec !{!"private", !"private"}
  %0 = load i32, ptr %seedval.addr, align 4, !sec !{!"public", !"public"}
  %and = and i32 %0, 65535, !sec !{!"public"}
  %conv = zext i32 %and to i64, !sec !{!"public"}
  store i64 %conv, ptr getelementptr inbounds ([3 x i64], ptr @x, i64 0, i64 1), align 8, !sec !{!"private", !"private", !"private", !"private", !"private"}
  %1 = load i32, ptr %seedval.addr, align 4, !sec !{!"public", !"public"}
  %shr = ashr i32 %1, 16, !sec !{!"public"}
  %and1 = and i32 %shr, 65535, !sec !{!"public"}
  %conv2 = zext i32 %and1 to i64, !sec !{!"public"}
  store i64 %conv2, ptr getelementptr inbounds ([3 x i64], ptr @x, i64 0, i64 2), align 16, !sec !{!"private", !"private", !"private", !"private", !"private"}
  store i64 58989, ptr @a, align 16, !sec !{!"private", !"private"}
  store i64 57068, ptr getelementptr inbounds ([3 x i64], ptr @a, i64 0, i64 1), align 8, !sec !{!"private", !"private", !"private", !"private", !"private"}
  store i64 5, ptr getelementptr inbounds ([3 x i64], ptr @a, i64 0, i64 2), align 16, !sec !{!"private", !"private", !"private", !"private", !"private"}
  store i64 11, ptr @c, align 8, !sec !{!"private", !"private"}
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
;? real_main
;? Purpose: Main test harness for B-tree operations
;?
;? Return value analysis:
;?   - Type: i32
;?   - Semantic meaning: Exit status code
;?   - Data it holds: Success/failure indicator
;?   - Security label: public
;?   - Rationale: Exit codes are typically observable
;?
;? Parameters: none
;?
;? Min-PC: public
;? Rationale: This is the main entry point called from public main(). While it performs
;? private tree operations internally, the function itself is invoked from public context.
;? Individual operations within the function handle their own private contexts as needed.
;? Return value is public (exit code).
define dso_local i32 @real_main() #0 !sec !{!"public", !"public", !{}} {
entry:                                            ; !sec !{!"public"}
  %input_file = alloca ptr, align 8, !sec !{!"public"}
  %fp = alloca ptr, align 8, !sec !{!"public"}
  %root = alloca ptr, align 8, !sec !{!"private"}
  %nelements = alloca i64, align 8, !sec !{!"public"}
  %nlookup = alloca i64, align 8, !sec !{!"public"}
  %total_mem = alloca i64, align 8, !sec !{!"public"}
  %elms = alloca ptr, align 8, !sec !{!"private"}
  %i = alloca i64, align 8, !sec !{!"public"}
  %i6 = alloca i64, align 8, !sec !{!"public"}
  %j = alloca i64, align 8, !sec !{!"private"}
  %tmp = alloca i64, align 8, !sec !{!"private"}
  %i21 = alloca i64, align 8, !sec !{!"public"}
  %sum = alloca i64, align 8, !sec !{!"private"}
  %start = alloca %struct.timeval, align 8, !sec !{!"public"}
  %end = alloca %struct.timeval, align 8, !sec !{!"public"}
  %i37 = alloca i64, align 8, !sec !{!"public"}
  %rdn = alloca i64, align 8, !sec !{!"private"}
  %r = alloca ptr, align 8, !sec !{!"private"}
  %e = alloca ptr, align 8, !sec !{!"private"}
  store ptr null, ptr %root, align 8, !sec !{!"public", !"private"}
  call void @myrandseed(i32 noundef -889275714), !sec !{!"call", !"void", !{!"public"}}
  store i64 1548576, ptr %nelements, align 8, !sec !{!"public", !"public"}
  store i64 1200000000, ptr %nlookup, align 8, !sec !{!"public", !"public"}
  %0 = load i64, ptr %nelements, align 8, !sec !{!"public", !"public"}
  %mul = mul i64 %0, 64, !sec !{!"public"}
  store i64 %mul, ptr %total_mem, align 8, !sec !{!"public", !"public"}
  %1 = load i64, ptr %total_mem, align 8, !sec !{!"private", !"public"}
  %call = call ptr @allocate(i64 noundef %1, i64 noundef 2097152), !sec !{!"call", !"private", !{!"private", !"private"}}
  store ptr %call, ptr %elms, align 8, !sec !{!"private", !"private"}
  %2 = load ptr, ptr %elms, align 8, !sec !{!"private", !"private"}
  %cmp = icmp eq ptr %2, null, !sec !{!"private"}
  %cmp.public = call i1 @declassify.i1(i1 noundef %cmp), !sec !{!"declassify", !"private", !"public"}
  br i1 %cmp.public, label %if.then, label %if.else, !sec !{!"public"}

if.then:                                          ; preds = %entry, !sec !{!"public"}
  %3 = load ptr, ptr @stderr, align 8, !sec !{!"public", !"public"}
  %call1 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %3, ptr noundef @.str.30), !sec !{!"call", !"public", !{!"public", !"public"}}
  call void @exit(i32 noundef 1) #7, !sec !{!"call", !"void", !{!"public"}}
  unreachable

if.else:                                          ; preds = %entry, !sec !{!"public"}
  %4 = load i64, ptr %total_mem, align 8, !sec !{!"private", !"public"}
  %public.4 = call i64 @declassify.i64(i64 noundef %4), !sec !{!"declassify", !"private", !"public"}
  %call2 = call i32 (ptr, ...) @printf(ptr noundef @.str.31, i64 noundef %public.4), !sec !{!"call", !"public", !{!"public", !"public"}}
  br label %if.end, !sec !{!"public"}

if.end:                                           ; preds = %if.else, !sec !{!"public"}
  store i64 0, ptr %i, align 8, !sec !{!"public", !"public"}
  br label %for.cond, !sec !{!"public"}

for.cond:                                         ; preds = %for.inc, %if.end, !sec !{!"public"}
  %5 = load i64, ptr %i, align 8, !sec !{!"private", !"public"}
  %6 = load i64, ptr %nelements, align 8, !sec !{!"private", !"public"}
  %cmp3 = icmp ult i64 %5, %6, !sec !{!"private"}
  %cmp3.public = call i1 @declassify.i1(i1 noundef %cmp3), !sec !{!"declassify", !"private", !"public"}
  br i1 %cmp3.public, label %for.body, label %for.end, !sec !{!"public"}

for.body:                                         ; preds = %for.cond, !sec !{!"public"}
  %7 = load ptr, ptr %elms, align 8, !sec !{!"private", !"private"}
  %8 = load i64, ptr %i, align 8, !sec !{!"public", !"public"}
  %arrayidx = getelementptr inbounds %struct.element, ptr %7, i64 %8, !sec !{!"private", !"private", !"public"}
  %key = getelementptr inbounds %struct.element, ptr %arrayidx, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  store i64 4, ptr %key, align 8, !sec !{!"public", !"private"}
  %9 = load ptr, ptr %elms, align 8, !sec !{!"private", !"private"}
  %10 = load i64, ptr %i, align 8, !sec !{!"public", !"public"}
  %arrayidx4 = getelementptr inbounds %struct.element, ptr %9, i64 %10, !sec !{!"private", !"private", !"public"}
  %stats = getelementptr inbounds %struct.element, ptr %arrayidx4, i32 0, i32 1, !sec !{!"private", !"private", !"public", !"public"}
  store i64 0, ptr %stats, align 8, !sec !{!"public", !"private"}
  %11 = load ptr, ptr %elms, align 8, !sec !{!"private", !"private"}
  %12 = load i64, ptr %i, align 8, !sec !{!"public", !"public"}
  %arrayidx5 = getelementptr inbounds %struct.element, ptr %11, i64 %12, !sec !{!"private", !"private", !"public"}
  %value = getelementptr inbounds %struct.element, ptr %arrayidx5, i32 0, i32 2, !sec !{!"private", !"private", !"public", !"public"}
  store i64 1, ptr %value, align 8, !sec !{!"public", !"private"}
  br label %for.inc, !sec !{!"public"}

for.inc:                                          ; preds = %for.body, !sec !{!"public"}
  %13 = load i64, ptr %i, align 8, !sec !{!"public", !"public"}
  %inc = add i64 %13, 1, !sec !{!"public"}
  store i64 %inc, ptr %i, align 8, !sec !{!"public", !"public"}
  br label %for.cond, !llvm.loop !53, !sec !{!"public"}

for.end:                                          ; preds = %for.cond, !sec !{!"public"}
  %14 = load i64, ptr %nelements, align 8, !sec !{!"public", !"public"}
  store i64 %14, ptr %i6, align 8, !sec !{!"public", !"public"}
  br label %for.cond7, !sec !{!"public"}

for.cond7:                                        ; preds = %for.inc19, %for.end, !sec !{!"public"}
  %15 = load i64, ptr %i6, align 8, !sec !{!"private", !"public"}
  %cmp8 = icmp ugt i64 %15, 1, !sec !{!"private"}
  %cmp8.public = call i1 @declassify.i1(i1 noundef %cmp8), !sec !{!"declassify", !"private", !"public"}
  br i1 %cmp8.public, label %for.body9, label %for.end20, !sec !{!"public"}

for.body9:                                        ; preds = %for.cond7, !sec !{!"public"}
  %call10 = call i64 @myrand(), !sec !{!"call", !"private", !{}}
  %16 = load i64, ptr %i6, align 8, !sec !{!"private", !"public"}
  %add = add i64 %16, 1, !sec !{!"private"}
  %rem = urem i64 %call10, %add, !sec !{!"private"}
  store i64 %rem, ptr %j, align 8, !sec !{!"private", !"private"}
  %17 = load ptr, ptr %elms, align 8, !sec !{!"private", !"private"}
  %18 = load i64, ptr %i6, align 8, !sec !{!"public", !"public"}
  %arrayidx11 = getelementptr inbounds %struct.element, ptr %17, i64 %18, !sec !{!"private", !"private", !"public"}
  %key12 = getelementptr inbounds %struct.element, ptr %arrayidx11, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %19 = load i64, ptr %key12, align 8, !sec !{!"private", !"private"}
  store i64 %19, ptr %tmp, align 8, !sec !{!"private", !"private"}
  %20 = load ptr, ptr %elms, align 8, !sec !{!"private", !"private"}
  %21 = load i64, ptr %j, align 8, !sec !{!"private", !"private"}
  %arrayidx13 = getelementptr inbounds %struct.element, ptr %20, i64 %21, !sec !{!"private", !"private", !"private"}
  %key14 = getelementptr inbounds %struct.element, ptr %arrayidx13, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %22 = load i64, ptr %key14, align 8, !sec !{!"private", !"private"}
  %23 = load ptr, ptr %elms, align 8, !sec !{!"private", !"private"}
  %24 = load i64, ptr %i6, align 8, !sec !{!"public", !"public"}
  %arrayidx15 = getelementptr inbounds %struct.element, ptr %23, i64 %24, !sec !{!"private", !"private", !"public"}
  %key16 = getelementptr inbounds %struct.element, ptr %arrayidx15, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  store i64 %22, ptr %key16, align 8, !sec !{!"private", !"private"}
  %25 = load i64, ptr %tmp, align 8, !sec !{!"private", !"private"}
  %26 = load ptr, ptr %elms, align 8, !sec !{!"private", !"private"}
  %27 = load i64, ptr %j, align 8, !sec !{!"private", !"private"}
  %arrayidx17 = getelementptr inbounds %struct.element, ptr %26, i64 %27, !sec !{!"private", !"private", !"private"}
  %key18 = getelementptr inbounds %struct.element, ptr %arrayidx17, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  store i64 %25, ptr %key18, align 8, !sec !{!"private", !"private"}
  br label %for.inc19, !sec !{!"public"}

for.inc19:                                        ; preds = %for.body9, !sec !{!"public"}
  %28 = load i64, ptr %i6, align 8, !sec !{!"public", !"public"}
  %dec = add i64 %28, -1, !sec !{!"public"}
  store i64 %dec, ptr %i6, align 8, !sec !{!"public", !"public"}
  br label %for.cond7, !llvm.loop !54, !sec !{!"public"}

for.end20:                                        ; preds = %for.cond7, !sec !{!"public"}
  store i64 0, ptr %i21, align 8, !sec !{!"public", !"public"}
  br label %for.cond22, !sec !{!"public"}

for.cond22:                                       ; preds = %for.inc29, %for.end20, !sec !{!"public"}
  %29 = load i64, ptr %i21, align 8, !sec !{!"private", !"public"}
  %30 = load i64, ptr %nelements, align 8, !sec !{!"private", !"public"}
  %cmp23 = icmp ult i64 %29, %30, !sec !{!"private"}
  %cmp23.public = call i1 @declassify.i1(i1 noundef %cmp23), !sec !{!"declassify", !"private", !"public"}
  br i1 %cmp23.public, label %for.body24, label %for.end31, !sec !{!"public"}

for.body24:                                       ; preds = %for.cond22, !sec !{!"public"}
  %31 = load ptr, ptr %root, align 8, !sec !{!"private", !"private"}
  %32 = load ptr, ptr %elms, align 8, !sec !{!"private", !"private"}
  %33 = load i64, ptr %i21, align 8, !sec !{!"public", !"public"}
  %arrayidx25 = getelementptr inbounds %struct.element, ptr %32, i64 %33, !sec !{!"private", !"private", !"public"}
  %key26 = getelementptr inbounds %struct.element, ptr %arrayidx25, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %34 = load i64, ptr %key26, align 8, !sec !{!"private", !"private"}
  %35 = load ptr, ptr %elms, align 8, !sec !{!"private", !"private"}
  %36 = load i64, ptr %i21, align 8, !sec !{!"public", !"public"}
  %arrayidx27 = getelementptr inbounds %struct.element, ptr %35, i64 %36, !sec !{!"private", !"private", !"public"}
  %37 = ptrtoint ptr %arrayidx27 to i64, !sec !{!"private"}
  %call28 = call ptr @insert(ptr noundef %31, i64 noundef %34, i64 noundef %37), !sec !{!"call", !"private", !{!"private", !"private", !"private"}}
  store ptr %call28, ptr %root, align 8, !sec !{!"private", !"private"}
  br label %for.inc29, !sec !{!"public"}

for.inc29:                                        ; preds = %for.body24, !sec !{!"public"}
  %38 = load i64, ptr %i21, align 8, !sec !{!"public", !"public"}
  %inc30 = add i64 %38, 1, !sec !{!"public"}
  store i64 %inc30, ptr %i21, align 8, !sec !{!"public", !"public"}
  br label %for.cond22, !llvm.loop !55, !sec !{!"public"}

for.end31:                                        ; preds = %for.cond22, !sec !{!"public"}
  %39 = load i64, ptr %nelements, align 8, !sec !{!"private", !"public"}
  %public.39 = call i64 @declassify.i64(i64 noundef %39), !sec !{!"declassify", !"private", !"public"}
  %call32 = call i32 (ptr, ...) @printf(ptr noundef @.str.32, i64 noundef %public.39), !sec !{!"call", !"public", !{!"public", !"public"}}
  %40 = load i64, ptr @order, align 8, !sec !{!"private", !"private"}
  %public.40 = call i64 @declassify.i64(i64 noundef %40), !sec !{!"declassify", !"private", !"public"}
  %call33 = call i32 (ptr, ...) @printf(ptr noundef @.str.33, i64 noundef %public.40), !sec !{!"call", !"public", !{!"public", !"public"}}
  %41 = load i64, ptr @allocator_stat, align 8, !sec !{!"private", !"private"}
  %shr = lshr i64 %41, 20, !sec !{!"private"}
  %shr.public = call i64 @declassify.i64(i64 noundef %shr), !sec !{!"declassify", !"private", !"public"}
  %call34 = call i32 (ptr, ...) @printf(ptr noundef @.str.34, i64 noundef %shr.public), !sec !{!"call", !"public", !{!"public", !"public"}}
  %call35 = call i32 @usleep(i32 noundef 250), !sec !{!"call", !"public", !{!"public"}}
  store i64 0, ptr %sum, align 8, !sec !{!"public", !"private"}
  %call36 = call i32 @gettimeofday(ptr noundef %start, ptr noundef null) #8, !sec !{!"call", !"public", !{!"public", !"public"}}
  store i64 0, ptr %i37, align 8, !sec !{!"public", !"public"}
  br label %for.cond38, !sec !{!"public"}

for.cond38:                                       ; preds = %for.inc55, %for.end31, !sec !{!"public"}
  %42 = load i64, ptr %i37, align 8, !sec !{!"private", !"public"}
  %43 = load i64, ptr %nlookup, align 8, !sec !{!"private", !"public"}
  %cmp39 = icmp ult i64 %42, %43, !sec !{!"private"}
  %cmp39.public = call i1 @declassify.i1(i1 noundef %cmp39), !sec !{!"declassify", !"private", !"public"}
  br i1 %cmp39.public, label %for.body40, label %for.end57, !sec !{!"public"}

for.body40:                                       ; preds = %for.cond38, !sec !{!"public"}
  %call41 = call i64 @myrand(), !sec !{!"call", !"private", !{}}
  %44 = load i64, ptr %nelements, align 8, !sec !{!"private", !"public"}
  %mul42 = mul i64 %44, 2, !sec !{!"private"}
  %rem43 = urem i64 %call41, %mul42, !sec !{!"private"}
  store i64 %rem43, ptr %rdn, align 8, !sec !{!"private", !"private"}
  %45 = load ptr, ptr %root, align 8, !sec !{!"private", !"private"}
  %46 = load i64, ptr %rdn, align 8, !sec !{!"private", !"private"}
  %call44 = call ptr @find(ptr noundef %45, i64 noundef %46, ptr noundef null), !sec !{!"call", !"private", !{!"private", !"private", !"private"}}
  store ptr %call44, ptr %r, align 8, !sec !{!"private", !"private"}
  %47 = load ptr, ptr %r, align 8, !sec !{!"private", !"private"}
  %tobool = icmp ne ptr %47, null, !sec !{!"private"}
  %tobool.public = call i1 @declassify.i1(i1 noundef %tobool), !sec !{!"declassify", !"private", !"public"}
  br i1 %tobool.public, label %if.then45, label %if.end54, !sec !{!"public"}

if.then45:                                        ; preds = %for.body40, !sec !{!"public"}
  %48 = load ptr, ptr %r, align 8, !sec !{!"private", !"private"}
  %value46 = getelementptr inbounds %struct.record, ptr %48, i32 0, i32 0, !sec !{!"private", !"private", !"public", !"public"}
  %49 = load i64, ptr %value46, align 8, !sec !{!"private", !"private"}
  %50 = inttoptr i64 %49 to ptr
  store ptr %50, ptr %e, align 8, !sec !{!"private", !"private"}
  %51 = load ptr, ptr %r, align 8, !sec !{!"private", !"private"}
  %stats47 = getelementptr inbounds %struct.record, ptr %51, i32 0, i32 3, !sec !{!"private", !"private", !"public", !"public"}
  %52 = load i64, ptr %stats47, align 8, !sec !{!"private", !"private"}
  %inc48 = add i64 %52, 1, !sec !{!"private"}
  store i64 %inc48, ptr %stats47, align 8, !sec !{!"private", !"private"}
  %53 = load ptr, ptr %e, align 8, !sec !{!"private", !"private"}
  %tobool49 = icmp ne ptr %53, null, !sec !{!"private"}
  %tobool49.public = call i1 @declassify.i1(i1 noundef %tobool49), !sec !{!"declassify", !"private", !"public"}
  br i1 %tobool49.public, label %if.then50, label %if.end53, !sec !{!"public"}

if.then50:                                        ; preds = %if.then45, !sec !{!"public"}
  %54 = load ptr, ptr %e, align 8, !sec !{!"private", !"private"}
  %value51 = getelementptr inbounds %struct.element, ptr %54, i32 0, i32 2, !sec !{!"private", !"private", !"public", !"public"}
  %55 = load i64, ptr %value51, align 8, !sec !{!"private", !"private"}
  %56 = load i64, ptr %sum, align 8, !sec !{!"private", !"private"}
  %add52 = add i64 %56, %55, !sec !{!"private"}
  store i64 %add52, ptr %sum, align 8, !sec !{!"private", !"private"}
  br label %if.end53, !sec !{!"public"}

if.end53:                                         ; preds = %if.then50, %if.then45, !sec !{!"public"}
  br label %if.end54, !sec !{!"public"}

if.end54:                                         ; preds = %if.end53, %for.body40, !sec !{!"public"}
  br label %for.inc55, !sec !{!"public"}

for.inc55:                                        ; preds = %if.end54, !sec !{!"public"}
  %57 = load i64, ptr %i37, align 8, !sec !{!"public", !"public"}
  %inc56 = add i64 %57, 1, !sec !{!"public"}
  store i64 %inc56, ptr %i37, align 8, !sec !{!"public", !"public"}
  br label %for.cond38, !llvm.loop !56, !sec !{!"public"}

for.end57:                                        ; preds = %for.cond38, !sec !{!"public"}
  %call58 = call i32 @gettimeofday(ptr noundef %end, ptr noundef null) #8, !sec !{!"call", !"public", !{!"public", !"public"}}
  %58 = load i64, ptr %sum, align 8, !sec !{!"private", !"private"}
  %public.58 = call i64 @declassify.i64(i64 noundef %58), !sec !{!"declassify", !"private", !"public"}
  %tv_sec = getelementptr inbounds %struct.timeval, ptr %end, i32 0, i32 0, !sec !{!"public", !"public", !"public", !"public"}
  %59 = load i64, ptr %tv_sec, align 8, !sec !{!"private", !"public"}
  %tv_sec59 = getelementptr inbounds %struct.timeval, ptr %start, i32 0, i32 0, !sec !{!"public", !"public", !"public", !"public"}
  %60 = load i64, ptr %tv_sec59, align 8, !sec !{!"private", !"public"}
  %sub = sub nsw i64 %59, %60, !sec !{!"private"}
  %sub.public = call i64 @declassify.i64(i64 noundef %sub), !sec !{!"declassify", !"private", !"public"}
  %call60 = call i32 (ptr, ...) @printf(ptr noundef @.str.35, i64 noundef %public.58, i64 noundef %sub.public), !sec !{!"call", !"public", !{!"public", !"public", !"public"}}
  %call61 = call i32 (ptr, ...) @printf(ptr noundef @.str.36), !sec !{!"call", !"public", !{!"public"}}
  ret i32 0, !sec !{!"public"}
}

declare !sec !{!"public", !"public", !{!"public"}} i32 @usleep(i32 noundef) #1

; Function Attrs: nounwind
declare !sec !{!"public", !"public", !{!"public", !"public"}} i32 @gettimeofday(ptr noundef, ptr noundef) #6

; Function Attrs: nounwind
;? posix_memalign
;? Purpose: System call to allocate aligned memory
;?
;? Return value analysis:
;?   - Type: i32 (integer error code)
;?   - Semantic meaning: 0 on success, errno value on failure
;?   - Data it holds: System error status
;?   - Security label: public
;?   - Rationale: System call return values are non-sensitive. Error codes are public info.
;?
;? Parameter 1 (memptr):
;?   - Type: ptr (pointer to pointer)
;?   - Semantic meaning: Output parameter - receives allocated memory address
;?   - Usage in function: System writes allocated address here
;?   - Data it holds/points to: Will receive pointer to allocated memory (may become private)
;?   - Security label: private
;?   - Rationale: Output parameter that will point to memory that becomes part of tree structure
;?
;? Parameter 2 (alignment):
;?   - Type: i64 (alignment requirement)
;?   - Semantic meaning: Memory alignment in bytes
;?   - Usage in function: Specifies alignment for allocated memory
;?   - Data it holds: Alignment value (64, etc.)
;?   - Security label: public
;?   - Rationale: Alignment is a non-sensitive allocation parameter
;?
;? Parameter 3 (size):
;?   - Type: i64 (size in bytes)
;?   - Semantic meaning: Amount of memory to allocate
;?   - Usage in function: Specifies allocation size
;?   - Data it holds: Size value
;?   - Security label: public
;?   - Rationale: Allocation size is non-sensitive system parameter
;?
;? Min-PC: public
;? Rationale: Matches return type. System call must be invoked with public PC.
declare !sec !{!"private", !"private", !{!"private", !"private", !"private"}} i32 @posix_memalign(ptr noundef, i64 noundef, i64 noundef) #6

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nocallback nofree nosync nounwind willreturn }
attributes #3 = { noreturn nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #5 = { cold "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #7 = { noreturn nounwind }
attributes #8 = { nounwind }
attributes #9 = { cold }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
!10 = distinct !{!10, !7}
!11 = distinct !{!11, !7}
!12 = distinct !{!12, !7}
!13 = distinct !{!13, !7}
!14 = distinct !{!14, !7}
!15 = distinct !{!15, !7}
!16 = distinct !{!16, !7}
!17 = distinct !{!17, !7}
!18 = distinct !{!18, !7}
!19 = distinct !{!19, !7}
!20 = distinct !{!20, !7}
!21 = distinct !{!21, !7}
!22 = distinct !{!22, !7}
!23 = distinct !{!23, !7}
!24 = distinct !{!24, !7}
!25 = distinct !{!25, !7}
!26 = distinct !{!26, !7}
!27 = distinct !{!27, !7}
!28 = distinct !{!28, !7}
!29 = distinct !{!29, !7}
!30 = distinct !{!30, !7}
!31 = distinct !{!31, !7}
!32 = distinct !{!32, !7}
!33 = distinct !{!33, !7}
!34 = distinct !{!34, !7}
!35 = distinct !{!35, !7}
!36 = distinct !{!36, !7}
!37 = distinct !{!37, !7}
!38 = distinct !{!38, !7}
!39 = distinct !{!39, !7}
!40 = distinct !{!40, !7}
!41 = distinct !{!41, !7}
!42 = distinct !{!42, !7}
!43 = distinct !{!43, !7}
!44 = distinct !{!44, !7}
!45 = distinct !{!45, !7}
!46 = distinct !{!46, !7}
!47 = distinct !{!47, !7}
!48 = distinct !{!48, !7}
!49 = distinct !{!49, !7}
!50 = distinct !{!50, !7}
!51 = distinct !{!51, !7}
!52 = distinct !{!52, !7}
!53 = distinct !{!53, !7}
!54 = distinct !{!54, !7}
!55 = distinct !{!55, !7}
!56 = distinct !{!56, !7}
