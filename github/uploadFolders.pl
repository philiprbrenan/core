#!/usr/bin/perl
#-------------------------------------------------------------------------------
# Upload the the folders specified on the command line to GitHub from a workflow
# Philip R Brenan at gmail dot com, Appa Apps Ltd, 2020
#-------------------------------------------------------------------------------
=pod

Upload the specified folders from the workflow to the corresponding folders in

  perl uploadFolders.pl folder... names [--branch=<branch>]

the current repository on either the branch that triggered the workflow, or if
the:

  --branch=<branch>

keyword is present, the named branch.  If the branch does not already exist a
free standing branch, that is, a branch with no parents will be created.

=cut

use warnings FATAL => qw(all);
use strict;
use Data::Table::Text qw(:all);
use Data::Dump qw(dump);
use GitHub::Crud;

my $userRepo = $ENV{GITHUB_REPOSITORY};                                         # Repository to load to
$userRepo or die 'Cannot find environment variable: $GITHUB_REPOSITORY';

my $token    = $ENV{token};                                                     # Access token
$token or die 'Cannot find token';

my $branch;                                                                     # Branch to upload to
my @folders;                                                                    # List of folders to upload

parseCommandLineArguments                                                       # Parse the command line
 {my ($pos, $keys) = @_;
  @folders = @$pos;
  $branch  = $$keys{branch} // $ENV{GITHUB_REF} ;
 } \@ARGV, {branch=>"Optional branch (which must already exist) to upload to"};

$branch or die 'No branch specified';                                           # Confirm branch

push my @files, searchDirectoryTreesForMatchingFiles @folders;                  # Files to upload

my $files   = @files;
my $folders = @folders;

lll "Upload $files files in $folders folders to $userRepo, branch $branch";     # Title

my $g = GitHub::Crud::new;                                                      # Github controller
 ($g->userid, $g->repository)   = split m(/), $userRepo, 2;
  $g->branch                    = $branch;
  $g->personalAccessTokenFolder = $token;

$g->writeCommit(q(./), @files);                                                 # Create and write commit
lll "Commit created";                                                           # Summary of results
