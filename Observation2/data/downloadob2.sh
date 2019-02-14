#!/bin/sh

usage () {
    cat <<__EOF__
usage: $(basename $0) [-hlp] [-u user] [-X args] [-d args]
  -h        print this help text
  -l        print list of files to download
  -p        prompt for password
  -u user   download as a different user
  -X args   extra arguments to pass to xargs
  -d args   extra arguments to pass to the download program

__EOF__
}

username=mmarcano22
xargsopts=
prompt=
list=
while getopts hlpu:xX:d: option
do
    case $option in
    h)  usage; exit ;;
    l)  list=yes ;;
    p)  prompt=yes ;;
    u)  prompt=yes; username="$OPTARG" ;;
    X)  xargsopts="$OPTARG" ;;
    d)  download_opts="$OPTARG";;
    ?)  usage; exit 2 ;;
    esac
done

if test -z "$xargsopts"
then
   #no xargs option speficied, we ensure that only one url
   #after the other will be used
   xargsopts='-L 1'
fi

if [ "$prompt" != "yes" ]; then
   # take password (and user) from netrc if no -p option
   if test -f "$HOME/.netrc" -a -r "$HOME/.netrc"
   then
      grep -ir "dataportal.eso.org" "$HOME/.netrc" > /dev/null
      if [ $? -ne 0 ]; then
         #no entry for dataportal.eso.org, user is prompted for password
         echo "A .netrc is available but there is no entry for dataportal.eso.org, add an entry as follows if you want to use it:"
         echo "machine dataportal.eso.org login mmarcano22 password _yourpassword_"
         prompt="yes"
      fi
   else
      prompt="yes"
   fi
fi

if test -n "$prompt" -a -z "$list"
then
    trap 'stty echo 2>/dev/null; echo "Cancelled."; exit 1' INT HUP TERM
    stty -echo 2>/dev/null
    printf 'Password: '
    read password
    echo ''
    stty echo 2>/dev/null
fi

# use a tempfile to which only user has access 
tempfile=`mktemp /tmp/dl.XXXXXXXX 2>/dev/null`
test "$tempfile" -a -f $tempfile || {
    tempfile=/tmp/dl.$$
    ( umask 077 && : >$tempfile )
}
trap 'rm -f $tempfile' EXIT INT HUP TERM

echo "auth_no_challenge=on" > $tempfile
# older OSs do not seem to include the required CA certificates for ESO
echo "check-certificate=off"  >> $tempfile
if [ -n "$prompt" ]; then
   echo "--http-user=$username" >> $tempfile
   echo "--http-password=$password" >> $tempfile

fi
WGETRC=$tempfile; export WGETRC

unset password

if test -n "$list"
then cat
else xargs $xargsopts wget $download_opts 
fi <<'__EOF__'
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T11:30:53.176/MUSE.2017-06-03T11:30:53.176.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-14T02:28:17.414/MUSE.2017-06-14T02:28:17.414.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/STAGING/MUSE.2017-06-03T06:51:06.175.AT/MUSE.2017-06-03T06:51:06.175.xml" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-14T09:09:10.302/MUSE.2017-06-14T09:09:10.302.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T11:37:39.177/MUSE.2017-06-03T11:37:39.177.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T07:12:22.177/MUSE.2017-06-03T07:12:22.177.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T21:58:39.120/MUSE.2017-06-01T21:58:39.120.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T10:56:33.356/MUSE.2017-06-01T10:56:33.356.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T11:14:13.176/MUSE.2017-06-03T11:14:13.176.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T11:01:04.356/MUSE.2017-06-01T11:01:04.356.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T10:58:05.299/MUSE.2017-06-03T10:58:05.299.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-14T03:30:27.509/MUSE.2017-06-14T03:30:27.509.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-14T09:05:45.847/MUSE.2017-06-14T09:05:45.847.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T11:10:31.356/MUSE.2017-06-01T11:10:31.356.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T11:21:26.177/MUSE.2017-06-03T11:21:26.177.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T10:49:53.353/MUSE.2017-06-01T10:49:53.353.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-14T02:59:22.464/MUSE.2017-06-14T02:59:22.464.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T10:53:53.354/MUSE.2017-06-01T10:53:53.354.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T10:55:13.354/MUSE.2017-06-01T10:55:13.354.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T11:07:33.176/MUSE.2017-06-03T11:07:33.176.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/M.MUSE.2014-06-13T10:14:20.005/M.MUSE.2014-06-13T10:14:20.005.fits" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T11:14:34.356/MUSE.2017-06-01T11:14:34.356.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T11:11:33.177/MUSE.2017-06-03T11:11:33.177.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T11:33:33.176/MUSE.2017-06-03T11:33:33.176.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/M.MUSE.2014-08-27T12:50:13.527/M.MUSE.2014-08-27T12:50:13.527.fits" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T11:02:24.358/MUSE.2017-06-01T11:02:24.358.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T11:38:59.176/MUSE.2017-06-03T11:38:59.176.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T11:28:13.176/MUSE.2017-06-03T11:28:13.176.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T21:59:59.121/MUSE.2017-06-01T21:59:59.121.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T10:28:45.202/MUSE.2017-06-01T10:28:45.202.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/M.MUSE.2017-01-04T12:56:22.356/M.MUSE.2017-01-04T12:56:22.356.fits" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/STAGING/MUSE.2017-06-03T07:12:22.177.AT/MUSE.2017-06-03T07:12:22.177.xml" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T11:24:06.177/MUSE.2017-06-03T11:24:06.177.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T05:44:34.176/MUSE.2017-06-03T05:44:34.176.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T07:24:45.177/MUSE.2017-06-03T07:24:45.177.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T10:34:26.467/MUSE.2017-06-01T10:34:26.467.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/M.MUSE.2017-05-02T10:34:11.986/M.MUSE.2017-05-02T10:34:11.986.fits" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T11:32:13.175/MUSE.2017-06-03T11:32:13.175.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T11:29:33.177/MUSE.2017-06-03T11:29:33.177.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/M.MUSE.2014-12-02T10:49:18.173/M.MUSE.2014-12-02T10:49:18.173.fits" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T22:01:19.119/MUSE.2017-06-01T22:01:19.119.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T05:35:27.176/MUSE.2017-06-03T05:35:27.176.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T11:22:46.177/MUSE.2017-06-03T11:22:46.177.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T11:10:13.176/MUSE.2017-06-03T11:10:13.176.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T22:02:38.124/MUSE.2017-06-01T22:02:38.124.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T11:13:09.356/MUSE.2017-06-01T11:13:09.356.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T07:12:22.177.NL/MUSE.2017-06-03T07:12:22.177.NL.txt" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T21:57:19.120/MUSE.2017-06-01T21:57:19.120.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T11:15:33.177/MUSE.2017-06-03T11:15:33.177.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T11:08:53.180/MUSE.2017-06-03T11:08:53.180.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T10:32:10.093/MUSE.2017-06-01T10:32:10.093.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T11:36:19.177/MUSE.2017-06-03T11:36:19.177.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T07:17:38.175.NL/MUSE.2017-06-03T07:17:38.175.NL.txt" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T06:51:06.175/MUSE.2017-06-03T06:51:06.175.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T10:50:07.756/MUSE.2017-06-03T10:50:07.756.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T11:05:05.356/MUSE.2017-06-01T11:05:05.356.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/M.MUSE.2014-06-13T10:14:59.795/M.MUSE.2014-06-13T10:14:59.795.fits" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T11:15:54.355/MUSE.2017-06-01T11:15:54.355.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T10:52:33.356/MUSE.2017-06-01T10:52:33.356.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T07:17:38.175/MUSE.2017-06-03T07:17:38.175.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/STAGING/MUSE.2017-06-03T07:06:26.181.AT/MUSE.2017-06-03T07:06:26.181.xml" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T11:16:53.177/MUSE.2017-06-03T11:16:53.177.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-14T09:10:18.661/MUSE.2017-06-14T09:10:18.661.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T10:37:50.873/MUSE.2017-06-01T10:37:50.873.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T10:27:36.786/MUSE.2017-06-01T10:27:36.786.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T11:09:11.355/MUSE.2017-06-01T11:09:11.355.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/STAGING/MUSE.2017-06-03T07:01:06.181.AT/MUSE.2017-06-03T07:01:06.181.xml" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T10:51:15.934/MUSE.2017-06-03T10:51:15.934.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T22:05:18.122/MUSE.2017-06-01T22:05:18.122.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-14T09:03:29.705/MUSE.2017-06-14T09:03:29.705.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T11:26:46.177/MUSE.2017-06-03T11:26:46.177.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T11:04:47.177/MUSE.2017-06-03T11:04:47.177.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T07:24:45.177.NL/MUSE.2017-06-03T07:24:45.177.NL.txt" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T10:36:42.477/MUSE.2017-06-01T10:36:42.477.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T11:03:27.176/MUSE.2017-06-03T11:03:27.176.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T10:51:13.355/MUSE.2017-06-01T10:51:13.355.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-14T09:01:13.147/MUSE.2017-06-14T09:01:13.147.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-14T09:06:54.051/MUSE.2017-06-14T09:06:54.051.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/M.MUSE.2017-05-02T10:33:34.610/M.MUSE.2017-05-02T10:33:34.610.fits" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T10:29:53.574/MUSE.2017-06-01T10:29:53.574.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T10:54:40.760/MUSE.2017-06-03T10:54:40.760.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T10:47:51.113/MUSE.2017-06-03T10:47:51.113.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/M.MUSE.2017-01-10T13:23:53.413/M.MUSE.2017-01-10T13:23:53.413.fits" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T11:25:26.177/MUSE.2017-06-03T11:25:26.177.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/M.MUSE.2014-12-08T12:30:51.293/M.MUSE.2014-12-08T12:30:51.293.fits" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T10:26:28.423/MUSE.2017-06-01T10:26:28.423.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T22:03:58.120/MUSE.2017-06-01T22:03:58.120.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T10:44:33.355/MUSE.2017-06-01T10:44:33.355.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T10:45:53.356/MUSE.2017-06-01T10:45:53.356.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T10:31:01.845/MUSE.2017-06-01T10:31:01.845.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T11:19:54.355/MUSE.2017-06-01T11:19:54.355.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T10:55:48.817/MUSE.2017-06-03T10:55:48.817.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T07:01:06.181/MUSE.2017-06-03T07:01:06.181.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/M.MUSE.2014-06-13T10:15:21.400/M.MUSE.2014-06-13T10:15:21.400.fits" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T11:11:50.358/MUSE.2017-06-01T11:11:50.358.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T11:12:53.181/MUSE.2017-06-03T11:12:53.181.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/STAGING/MUSE.2017-06-03T07:24:45.177.AT/MUSE.2017-06-03T07:24:45.177.xml" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T10:56:57.003/MUSE.2017-06-03T10:56:57.003.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T10:33:18.250/MUSE.2017-06-01T10:33:18.250.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T10:48:59.548/MUSE.2017-06-03T10:48:59.548.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T10:35:34.468/MUSE.2017-06-01T10:35:34.468.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-14T09:04:37.892/MUSE.2017-06-14T09:04:37.892.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-14T09:11:26.912/MUSE.2017-06-14T09:11:26.912.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-14T09:12:35.272/MUSE.2017-06-14T09:12:35.272.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T10:48:33.356/MUSE.2017-06-01T10:48:33.356.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-14T04:01:32.482/MUSE.2017-06-14T04:01:32.482.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T07:01:06.181.NL/MUSE.2017-06-03T07:01:06.181.NL.txt" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T07:06:26.181/MUSE.2017-06-03T07:06:26.181.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-14T09:08:02.132/MUSE.2017-06-14T09:08:02.132.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T10:47:13.354/MUSE.2017-06-01T10:47:13.354.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T21:41:33.125/MUSE.2017-06-01T21:41:33.125.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T06:51:06.175.NL/MUSE.2017-06-03T06:51:06.175.NL.txt" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T11:18:34.356/MUSE.2017-06-01T11:18:34.356.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T22:06:38.119/MUSE.2017-06-01T22:06:38.119.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/STAGING/MUSE.2017-06-03T07:17:38.175.AT/MUSE.2017-06-03T07:17:38.175.xml" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T10:43:13.356/MUSE.2017-06-01T10:43:13.356.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-14T04:32:37.598/MUSE.2017-06-14T04:32:37.598.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T11:03:45.356/MUSE.2017-06-01T11:03:45.356.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T10:53:32.303/MUSE.2017-06-03T10:53:32.303.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T10:52:24.288/MUSE.2017-06-03T10:52:24.288.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T11:06:13.178/MUSE.2017-06-03T11:06:13.178.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/M.MUSE.2017-10-25T09:52:41.440/M.MUSE.2017-10-25T09:52:41.440.fits" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T07:06:26.181.NL/MUSE.2017-06-03T07:06:26.181.NL.txt" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T10:46:42.540/MUSE.2017-06-03T10:46:42.540.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T11:34:59.175/MUSE.2017-06-03T11:34:59.175.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T11:17:14.355/MUSE.2017-06-01T11:17:14.355.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T11:07:51.355/MUSE.2017-06-01T11:07:51.355.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/M.MUSE.2015-06-24T08:20:55.820/M.MUSE.2015-06-24T08:20:55.820.fits" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-14T09:02:21.403/MUSE.2017-06-14T09:02:21.403.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-03T11:40:19.176/MUSE.2017-06-03T11:40:19.176.fits.fz" -P data_with_raw_calibs
"https://dataportal.eso.org/dataPortal/api/requests/mmarcano22/400737/SAF/MUSE.2017-06-01T11:06:26.355/MUSE.2017-06-01T11:06:26.355.fits.fz" -P data_with_raw_calibs

__EOF__
