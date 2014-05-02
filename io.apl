#!apl -f

⍝  Helper functions that wrap the lib_file_io native library,
⍝  exposing functions that are more easy to use.

io∆∆bufsize ← 1000

∇Z←io∆readfile F;fd;result;rows;buf;mergenext;mergethis;row
  row ← 0
  result ← io∆∆bufsize ⍴ ' '
  mergenext ← 0
  fd ← IO[3] F

next:
  buf ← IO[8] fd
  →(0=⍴buf)/close

  mergethis ← mergenext

  ⍝ If the line ends with a linefeed, drop it.
  ⍝ Otherwise indicate that the next line should be
  ⍝ merged with the previous.
  mergenext ← 1
  →(10≠¯1↑buf)/no¯lf
  buf ← ¯1↓buf
  mergenext ← 0
no¯lf:

  ⍝ If this line should be merged with the previous,
  ⍝ jump to the merge code
  →mergethis/merge

  ⍝ No merge, check if the result needs to be resized
  →(row<⍴result)/no¯resize
  result ← result,io∆∆bufsize⍴' '
no¯resize:
  result[⎕IO+row] ← ⊂⎕UCS buf
  row ← row+1
  →next

merge:
  result[⎕IO+row] ← result[⎕IO+row],⎕UCS buf
  →next

close:
  buf ← IO[4] fd
  Z ← row ⍴ result
∇

∇Z←SEPARATOR io∆split S
  →(0≠⎕NC 'SEPARATOR')/nodefault
  SEPARATOR ← ','
nodefault:
  Z ← (~SEPARATOR⍷S)⊂S
∇

∇Z←X io∆trim S;LENGTH
  →(0≠⎕NC 'X')/nodefault
  X ← ' '
nodefault:
  LENGTH ← ⎕IO+↑⍴,X
  S ← (+/×\LENGTH≠X⍳S)↓S
  Z ← (-+/×\LENGTH≠X⍳⌽S)↓S
∇

∇io∆∆load_library;result
  →(0≠⎕NC 'IO')/skip
  result ← 'lib_file_io' ⎕FX 'IO'
  →('IO'≡result)/skip
  ⎕ES 'Error loading native library'
skip:
∇

io∆∆load_library
)erase io∆∆load_library

⎕←'IO lib loaded'
