# sonos-flic

This is how I wired up my [flic bluetooth buttons](https://flic.io) with my [Sonos](http://www.sonos.com).

[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/qPZerEtexoA/0.jpg)](https://youtu.be/qPZerEtexoA)


## Installation

```
git clone https://github.com/masone/sonos-flic.git
cd sonos-flic
bundle install
```

## Usage

```
bundle exec ruby server.rb
```

## Installation on Raspberry Pi

```
sudo crontab -e
cd /home/pi/sonos-flic/ && bundle exec ruby server.rb &
```
