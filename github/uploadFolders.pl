#!/usr/bin/perl
#-------------------------------------------------------------------------------
# Upload the the folders specified on the command line to GitHub from a workflow
# Philip R Brenan at gmail dot com, Appa Apps Ltd, 2020
#-------------------------------------------------------------------------------
use warnings FATAL => qw(all);
use strict;
use Data::Table::Text qw(:all);
use GitHub::Crud;

my $userRepo = $ENV{GITHUB_REPOSITORY};                                         # Repository to load to
$userRepo or die 'Cannot find environment variable: $GITHUB_REPOSITORY';

my $token    = $ENV{token};                                                     # Access token
$token or die 'Cannot find token';
                                                                                # Choose a branch
my $branch   = sub
 {return $ARGV[0] if @ARGV;
  q(master)
 }->();

lll "Upload folders to $userRepo, branch $branch";                              # Title

my $folders;                                                                    # Number of folders uploaded

for my $folder(@ARGV)                                                           # Upload each folder specified on the command line
 {lll $folder;
  unless(-d $folder)
   {lll "No such folder: $folder";
    next;
   }

  my $g = GitHub::Crud::new;                                                    # Github controller
 ($g->userid, $g->repository)   = split m(/), $userRepo, 2;
  $g->branch                    = $branch;
  $g->personalAccessTokenFolder = $token;

  for my $file(searchDirectoryTreesForMatchingFiles($folder))                   # Load each file
   {$g->gitFile = $file;
    $g->write(readBinaryFile($file));
   }

  ++$folders
 }

say STDERR "$folders uploaded";                                                 # Summary of results
