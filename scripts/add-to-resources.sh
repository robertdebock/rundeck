#!/bin/bash

# Description of the function of this script.

usage() {
  echo "Usage: $0 [-o option] -a argument"
  echo
  echo "  -f FILE"
  echo "    The text file to use as input. Every line should contain one"
  echo "    hostname."
  echo "  -r RESOURCEFILE"
  echo "    The resource.xml file."
  echo "  -t TAG"
  echo "    The TAG to add to the hostname."
  echo "  -u USERNAME"
  echo "    The username to use to connect."
  echo
  exit 1
}

readargs() {
  while [ "$#" -gt 0 ] ; do
    case "$1" in
      -f)
        if [ "$2" ] ; then
          file="$2"
          shift ; shift
        else
          echo "Missing a value for $1."
          echo
          shift
          usage
        fi
      ;;
      -r)
	if [ "$2" ] ; then
	  resourcefile="$2"
	  shift ; shift
	else
	  echo "Missing a value for $1."
	  echo
	  shift
          usage
        fi
      ;;
      -t)
        if [ "$2" ] ; then
          tags="$2"
          shift ; shift
        else
          echo "Missing a value for $1."
          echo
          shift
          usage
        fi
      ;;
      -u)
        if [ "$2" ] ; then
          username="$2"
          shift ; shift
        else
          echo "Missing a value for $1."
          echo
          shift
          usage
        fi
      ;;
      *)
        echo "Unknown option or argument $1."
        echo
        shift
        usage
      ;;
    esac
  done
}

checkargs() {
  if [ ! "${file}" ] ; then
    echo "Missing file."
    usage
    exit 2
  fi
  if [ ! "${resourcefile}" ] ; then
    echo "Missing resourcefile."
    usage
    exit 3
  fi
  if [ ! "${username}" ] ; then
    echo "Missing the username."
    usage
    exit 4
  fi
}

setargs() {
  if [ ! "${tags}" ] ; then
    tags="default"
  fi
}

checkvalues() {
  if [ ! -f "${file}" ] ; then
   echo "$file does not exist."
   exit 5
   usage
  fi
  if [ ! -f "${resourcefile}" ] ; then
   echo "$resourcefile does not exist."
   exit 6
   usage
  fi
}

main() {
  # Remove the closing tag.
  sed -i '' -e '$ d' ${resourcefile}

  # Add the hosts.
  cat ${file} | while read hostname ; do
    # If the host is already in the file, don't add it.
    grep "${hostname}" "${resourcefile}" > /dev/null 2>&1
    if [ $? != 0 ] ; then
      echo "  <node name=\"${hostname}\" tags=\"${tags}\" hostname=\"${hostname}\" username=\"${username}\"/>" >> "${resourcefile}"
    fi
  done

  # Add the closing tag.
  echo "</project>" >> "${resourcefile}"
}

readargs "$@"
checkargs
setargs
checkvalues
main
