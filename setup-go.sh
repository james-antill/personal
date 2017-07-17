#! /bin/sh -e

if [ -x setup-dirs.sh ]; then
        ./setup-dirs.sh
fi

for i in uitime ; do
        if [ ! -d $i ]; then
                go get -u github.com/james-antill/$i
        fi
done

for i in github.com/anacrolix/torrent/cmd/torrent \
         github.com/a8m/tree/cmd/tree \
         github.com/cavaliercoder/grab/cmd/grab \
         github.com/bcicen/ctop \
         github.com/syncthing/syncthing \
         github.com/restic/restic/src/cmds/restic \
         github.com/d4l3k/go-pry \
         ; do
        if [ ! -d $i ]; then
                echo $i
                go get -u $i || true
        fi
done

