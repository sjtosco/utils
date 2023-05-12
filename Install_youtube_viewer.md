# Install Youtube lightweight viewer app on Debian 10
> based on: https://askubuntu.com/questions/1029038/solvedcan-i-use-youtube-viewer-on-ubuntu18-04

## Installation

### Dependencies
```bash
sudo apt install git libncurses5-dev libtinfo-dev libreadline-dev pkg-config libgtk2.0-dev libcanberra-gtk-module
```
### From source code 
```bash
git clone https://github.com/trizen/youtube-viewer
cd youtube-viewer
sudo cpan install CPAN ExtUtils::PkgConfig Module::Build inc::latest PAR::Dist Term::ReadLine::Gnu::XS Unicode::GCString LWP::Protocol::https Data::Dump JSON Gtk2 File::ShareDir
perl Build.PL --gtk
sudo ./Build installdeps
sudo ./Build install
```
