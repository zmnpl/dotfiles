#!/usr/bin/perl --
use strict;
use warnings;
use v5.10;
use File::Path qw(make_path);
use File::Copy;
use File::Basename;
use Cwd;
#use LWP::Simple;
##########################################################
# author: simon paul
# email: simonpaul@mailbox.org
# attention: feel free to use, modify, distribute on own risk!

##########################################################
# instructions
# search for settings comment to set configure everything
# maybe push more files into @dotfiles
##########################################################
# general
#
# constants
my $gitRecursive = "rec";
my $gitNormal = "norm";
# settings
my $printspacer = "#######################################################";
my $home = glob("~/");
my $dotfolder = $home."dotfiles/";
my $oldfiles = $dotfolder."backup/";

chdir $dotfolder;

&dotLink($dotfolder."bashrc", $home.".bashrc");
&dotLink($dotfolder."xprofile", $home.".xprofile");
&dotLink($dotfolder."Xresources", $home.".Xresources");
##########################################################
# vim
#
# settings
my $vimdir = $dotfolder."vim/";
# vim dotfiles
&dotLink($dotfolder."vim", $home."vim");
&dotLink($dotfolder."vimrc", $home.".vimrc");
# neovim
&dotLink($vimdir, $home.".config/nvim");
&dotLink($dotfolder."vimrc", $home.".config/nvim/init.vim");

# pathogen
if (! -d $vimdir."/bundle/") {
	make_path($vimdir."/bundle/") || say("could not create ".$vimdir."/bundle/: $!");
}
if (! -d $vimdir."/autoload/") {
	make_path($vimdir."/autoload/") || say("could not create ".$vimdir."/autoload/: $!");
}
updateViaWget('https://tpo.pe/pathogen.vim', 'vim/autoload/pathogen.vim');

# vim plugins
cloneVimPlugin('https://github.com/Shougo/neocomplete.vim.git', $gitNormal);
cloneVimPlugin('https://github.com/scrooloose/nerdtree.git', $gitNormal);
cloneVimPlugin('https://github.com/majutsushi/tagbar.git', $gitNormal);
cloneVimPlugin('https://github.com/bling/vim-airline.git', $gitNormal);
cloneVimPlugin('https://github.com/ntpeters/vim-better-whitespace.git', $gitNormal);
cloneVimPlugin('https://github.com/fatih/vim-go.git', $gitNormal);

##########################################################
# zsh - prezto
#
# clone preto from sorin
gitCloneOrPull("https://github.com/sorin-ionescu/prezto.git", $home.".zprezto/", $gitRecursive);
# link all configs
foreach(glob($dotfolder."zprezto/"."runcoms/z*")) {
	&dotLink($_, $home.".".basename($_));
}

#########################################################################################
#########################################################################################

# checks if given directory exists
# if so switches into it and pulls (i.e. update repo)
# if not clones
sub gitCloneOrPull() {
	my $repo = shift;
	my $destination = shift;
	my $mode = shift;
	my $dir = getcwd;

	say($printspacer);
	# decide if giwgetsubmodules or without
	# checks, if destination already exists; if so updates instead of pulling
	if ($mode eq $gitNormal){
		if (! -d $destination) {
			say("cloning ".basename($destination)); # todo - maybe use git wrapper
			system("git", "clone", $repo, $destination);
		} else {
			say("updating ".basename($destination));
			chdir $destination;
			system("git", "pull");
			chdir $dir;
		}
	} elsif ($mode eq $gitRecursive) {
		if (! -d $destination) {
			say("cloning ".basename($destination)); # todo - maybe use git wrapper
			system("git", "clone", "--recursive", $repo, $destination);
		} else {
			say("updating ".basename($destination));
			chdir $destination;
			system("git", "pull");
			system("git", "submodule", "foreach", "--recursive", "git", "pull", "origin", "master");
			chdir $dir;
		}
	}
	say($printspacer);
}

sub cloneVimPlugin() {
	my $p = shift;
	my $mode = shift;
	my ($folder) = $p =~ m/.*\/(.*)\.git/;
	my $plugin = $vimdir."/bundle/".$folder;
	&gitCloneOrPull($p, $plugin, $mode);
}

# creates .dotfile link in given destination
# saves copy in backup folder, if it was an actual file and not a symlink
sub dotLink() {
	my $dotfile = shift;
	my $link = shift;

	if(-l $link) {
		unlink $link # symlinks will be removed anyways; nothing to backup here ...
	} elsif (-f $link || -d $link) {
		say("backing up $link");
		move($link, $oldfiles.time().basename($dotfile)) || die "could not backup $link: $!" # timestamp in filename to avoid overwriting
	}

	my $linked = eval { symlink($dotfile, $link); 1 };
	if($linked) {
		say("created symlink: $dotfile -> $link")
	} else {
		say("could not create symlink: $dotfile -> $link\n$!")
	}
}

# downloads file with wget and replaces old one
sub updateViaWget() {
	my $url = shift;
	my $file = shift;
	$file = $file;

	say("downloading $url");
	system("wget --output-document=".$file."~"." ".$url);
	if(-f $file) {
		unlink($file)
	}
	move($file."~", $file)
}
