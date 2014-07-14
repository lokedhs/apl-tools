#!apl -f

∇Z←doc∆getdoc NAME;content
⍝ Returns the documentation for function NAME.
⍝ If the function has no documentation, or the
⍝ function does not exist, return ⍬
  →(3≠⎕NC NAME)/fail
  content ← 1↓[⎕IO] ⎕CR NAME
  Z ← io∆trim¨ ⊂[⎕IO+1] content[⍳ +/×\ '⍝' = content[;⎕IO] ; 1↓⍳(⍴content)[⎕IO+1]]
  →end
fail:
  Z←⍬
end:
∇
