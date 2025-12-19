; ModuleID = 'double.c'
source_filename = "double.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @init(ptr noundef %p) #0 !sec !{!"void", !"private", !{!"private"}} {
entry:                                            ; !sec !{!"private"}
  %p.addr = alloca ptr, align 8, !sec !{!"private"}
  store ptr %p, ptr %p.addr, align 8, !sec !{!"private", !"private"}
  %0 = load ptr, ptr %p.addr, align 8, !sec !{!"private", !"private"}
  store i32 1, ptr %0, align 4, !sec !{!"public", !"private"}
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @double_1(ptr noundef %p) #0 !sec !{!"private", !"private", !{!"private"}} {
entry:                                            ; !sec !{!"private"}
  %p.addr = alloca ptr, align 8, !sec !{!"private"}
  %tmp = alloca i32, align 4, !sec !{!"private"}
  store ptr %p, ptr %p.addr, align 8, !sec !{!"private", !"private"}
  %0 = load ptr, ptr %p.addr, align 8, !sec !{!"private", !"private"}
  %1 = load i32, ptr %0, align 4, !sec !{!"private", !"private"}
  store i32 %1, ptr %tmp, align 4, !sec !{!"private", !"private"}
  %2 = load i32, ptr %tmp, align 4, !sec !{!"private", !"private"}
  %mul = mul nsw i32 2, %2, !sec !{!"private"}
  %3 = load ptr, ptr %p.addr, align 8, !sec !{!"private", !"private"}
  store i32 %mul, ptr %3, align 4, !sec !{!"private", !"private"}
  %4 = load ptr, ptr %p.addr, align 8, !sec !{!"private", !"private"}
  %5 = load i32, ptr %4, align 4, !sec !{!"private", !"private"}
  ret i32 %5, !sec !{!"private"}
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !sec !{!"public", !"public", !{}} {
entry:                                            ; !sec !{!"public"}
  %retval = alloca i32, align 4, !sec !{!"public"}
  %r = alloca i32, align 4, !sec !{!"private"}
  %p = alloca ptr, align 8, !sec !{!"private"}
  store i32 0, ptr %retval, align 4, !sec !{!"public", !"public"}
  store i32 0, ptr %r, align 4, !sec !{!"public", !"private"}
  %call = call noalias ptr @malloc(i64 noundef 4) #2, !sec !{!"private"}
  store ptr %call, ptr %p, align 8, !sec !{!"private", !"private"}
  %0 = load ptr, ptr %p, align 8, !sec !{!"private", !"private"}
  call void @init(ptr noundef %0), !sec !{!"call", !"void", !{!"private"}}
  %1 = load ptr, ptr %p, align 8, !sec !{!"private", !"private"}
  %call1 = call i32 @double_1(ptr noundef %1), !sec !{!"call", !"private", !{!"private"}}
  store i32 %call1, ptr %r, align 4, !sec !{!"private", !"private"}
  %2 = load i32, ptr %r, align 4, !sec !{!"private", !"private"}
  %3 = call i32 @declassify.i32(i32 noundef %2) #2, !sec !{!"declassify", !"private", !"public"}
  ret i32 %3, !sec !{!"public"}
}

; Function Attrs: nounwind allocsize(0)
declare !sec !{!"public", !"public", !{}} noalias ptr @malloc(i64 noundef) #1

;
define i32 @declassify.i32(i32 noundef %0) #2 !sec !{!"public", !"public", !{!"private"}} {
  ret i32 %0, !sec !{!"public"}
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind allocsize(0) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind allocsize(0) }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"Ubuntu clang version 17.0.6 (++20231208085846+6009708b4367-1~exp1~20231208085949.74)"}

; Synthesized wrapper functions:
