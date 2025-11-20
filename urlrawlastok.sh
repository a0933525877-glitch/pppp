total=$(cat $1 | wc -l)
a=0
b=$(echo $RANDOM | md5sum | head -c 6)
echo "Un total de $total site a scan"
mkdir dir$b
split $1 -l 500 dir$b/$b
ls dir$b/ | grep $b >list.$b




for lsline in $(cat list.$b);do
b2=$(echo $RANDOM | md5sum | head -c 6)
httpx -silent -sr -srd $b2 -t 300 -l dir$b/$lsline >1
#grep -r -h -Eo "(http|https)://[a-zA-Z0-9./?=_-]*" $b2/ | egrep -v "facebook|reddit|wiki|twitter|instagram|github.com|jpg|png|jpeg|\.ico|\.gif" | sort -u >>url.$b2
grep -r -Eo "/[a-zA-Z0-9./?=_-]*\.(js)" $b2/ | sed "s/$b2\///" | sed "s/\.txt\://" | sed 's/\[slash\]/\//g' >>url.$b2
rm -r $b2

a=$((a+500))
#httpx -silent -l httpx.$b2 -t 500 -mr "REACT_.{300}" -er "REACT_.{300}" >>react
httpx -silent -l url.$b2 -t 500 -mr "api.infusionsoft.com" >infusionsoft.$b2
httpx -silent -l url.$b2 -t 500 -mr "a.klaviyo.com/api" >klaviyo.$b2




httpx -silent -sr -srd infusionsofts -l infusionsoft.$b2
httpx -silent -sr -srd klaviyos -l klaviyo.$b2
echo "FINI $lsline total [$a]"
rm url.$b2
rm aws.$b2
done
rm -r list.$b
rm -r dir$b
