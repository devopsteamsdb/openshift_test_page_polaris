param($testname,$size,$numjobs)

$content = @"
[random-rw]
rw=randrw
size=$size
blocksize=64k
ioengine=libaio
directory=/home/myuser/tmp
numjobs=$numjobs
iodepth=32
group_reporting
"@

Set-Content "/home/myuser/$testname.fio" -Value $content

$run = fio /home/myuser/$testname.fio

foreach ($line in $run){
    $line
    "<br>"
}