∇Z←readfile F;fd;result;buf
  result ← ⍬
  fd ← IO[3] F
next:
  buf ← IO[8] fd
  →(0=⍴buf)/close

  ⍝ If the line ends with a linefeed, drop it
  →(10≠¯1↑buf)/no¯lf
  buf ← ¯1↓buf
no¯lf:

  result ← result,(⊂⎕UCS buf)
  →next

close:
  buf ← IO[4] fd
  Z ← result
∇
