param($testname,$size,$numjobs)

$content = @"
[random-rw]
rw=randrw
size=$size
blocksize=64k
ioengine=libaio
directory=/mnt
numjobs=$numjobs
iodepth=32
group_reporting
"@

Set-Content "/tmp/$testname.fio" -Value $content

$run = fio /tmp/$testname.fio

foreach ($line in $run){
    $line
    "<br>"
}