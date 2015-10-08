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
my @dotfiles; # push all dotfiles in here

chdir $dotfolder;
push(@dotfiles, $dotfolder."bashrc");
push(@dotfiles, $dotfolder."xprofile");
##########################################################
# vim
#
# settings
my $vimdir = $dotfolder."vim/";
# vim dotfiles
push(@dotfiles, $vimdir);
push(@dotfiles, $dotfolder."vimrc");

# pathogen
if (! -d $vimdir."/bundle/") {
	make_path($vimdir."/bundle/") || say("could not create ".$vimdir."bundle/: $!");
}
updateViaWget('https://tpo.pe/pathogen.vim', 'vim/autoload/pathogen.vim');

cloneVimPlugin('https://github.com/Shougo/neocomplete.vim.git', $gitNormal);
cloneVimPlugin('https://github.com/scrooloose/nerdtree.git', $gitNormal);
cloneVimPlugin('https://github.com/majutsushi/tagbar.git', $gitNormal);
cloneVimPlugin('https://github.com/bling/vim-airline.git', $gitNormal);
cloneVimPlugin('https://github.com/ntpeters/vim-better-whitespace.git', $gitNormal);
cloneVimPlugin('https://github.com/fatih/vim-go.git', $gitNormal);

##########################################################
# zsh - prezto
#
# settings
my $preztodir = $dotfolder."zprezto/";
# zsh/prezto dotfiles
push(@dotfiles, $preztodir);

gitCloneOrPull("https://github.com/zmnpl/prezto.git", $preztodir, $gitRecursive);

# push all prezto configs to @dotfiles
foreach(glob($preztodir."runcoms/z*")) {
	push(@dotfiles, $_)
}

##########################################################
# linking - actual installation
#
#settings
foreach(@dotfiles) {
	&dotLink($home, $_);
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
	# decide if git with submodules or without
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
	my $destination = shift;
	my $dotfile = shift;
	$destination = $destination.".".basename($dotfile);

	if(-l $destination) {
		unlink $destination # symlinks will be removed anyways; nothing to backup here ...
	} elsif (-f $destination || -d $destination) {
		say("backing up $destination");
		move($destination, $oldfiles.time().basename($dotfile)) || die "could not backup $destination: $!" # timestamp in filename to avoid overwriting
	}

	my $linked = eval { symlink($dotfile, $destination); 1 };
	if($linked) {
		say("created symlink: $dotfile -> $destination")
	} else {
		say("could not create symlink: $dotfile -> $destination\n$!")
	}
}

# downloads file with gestore and replaces old one
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

	#my $status = getstore($url, $file."~");
	#if (is_success($status) && -f $file."~") {
	#	unlink($file);
	#	move($file."~", $file);
	#}
}
