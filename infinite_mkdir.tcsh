#!/bin/tcsh

set depthCount = 0

while ($depthCount < 10000)
  if !(-d test) then
    mkdir test
  endif
  if (-d test) then
    cd test
    @ depthCount ++
  else
    echo "Kilroy was here."
    break
  endif
end

echo $depthCount
