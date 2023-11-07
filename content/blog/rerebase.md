+++
title = "Re-rebase"
description = "Or: Undo Rebases without git reflog (But git reflog is useful!)"
date = "2023-11-06"
+++

## Learning Git is hard, especially rebases

In my job, I've been helping others learn git for quite some time now. I've spent  lot of time learning git inside and out myself to make sure I know what I'm talking about, as well as reading blog posts and finding tutorials to recommend to others. One thing I keep coming across is difficulties with rebases. This includes my issues with rebases, I've gotten into some real good messes.

All this is to say I was ecstatic to see [Julia Evans wrote a blog post about problems with rebases](https://jvns.ca/blog/2023/11/06/rebasing-what-can-go-wrong-/). I love reading her posts, they're super well written and informative. And this one is too! If you somehow got to this blog without first finding [jvns.ca](https://jvns.ca) go there and read up!

All that is to say that despite the fact I'm about to complain a bunch, really I feel this is a minor nitpick about a great post. More so, my complaint is something more widespread. I've seen the "standard" advice that I don't like giving out so many times, I think it's probably the first thing a lot of people will see when learning about fixing rebases.

But one thing rubbed me the wrong way:

## git reflog doesn't undo rebases

I come across this advice all the time, and I remember it really confused me when I was learning rebasing. The situation I often got into was:
- Screw up a rebase
- Search online for help
- See the advice of "use git reflog!"
- Type `git reflog` in my terminal, and get confused with the output
- Give up and start fresh on another copy of the branch

This really comes down to just how the advice is worded - I do (sometimes) use `git reflog` to fix rebases! But it's not reflog that does the fixing, it's `git reset --hard <the commit hash>`. `git reflog` is just a tool for getting the commit hash, and there are other options for that.

## I wish the standard advice looked like this

> Use `git reset --hard <the original commit>` to fix a bad rebase. If you don't know the original commit's hash, you can look it up with `git reflog`.

## Why I think this confusion exists in the first place

One thing I've come across a number of times is that what a rebase does is surprising. I think a lot of people assume it moves commits - I know that's what I thought way back when. Now, when I help people fix bad rebases, the first thing I do is teach them three concepts.

### Branches are pointers

Teaching folks that the branch they're using is actually a simple pointer goes a long way to explaining why `git reset` works. Knowing you can move the pointer around without moving the commits really helps! I find people tend to think of the branch as the collection of commits, and so assume that moving branches is harder, more like a rebase.

### Rebasing makes new commits

This is the big one, I've talked to really experienced devs who I think didn't realize this part.

Really, you don't need to do anything to undo a rebase, the old commits are still just there. Running `git rebase` actually creates new commits with the same changes, without touching the existing ones. The only exception to this I've found is when there's literally nothing different between the "new" and "old" commits, in that case they're exactly the same!

One tutorial I like pointing people to shows this really well - try out [Learn Git Branching](https://learngitbranching.js.org/) if you want to get better at git!

### (almost) Everything in git is content-addressed

I find I tend to lose people here, but I'm trying to get better at explaining it.

Most things you'll work with in git (files, directories and commits) are content-addressed. That is, they're given a filename made out of the SHA-1 hash of the content. That's what a commit hash is, it's a file name.

With that in mind it should make sense why having literally no differences between commits means it reuses the same commit - it's the same hash, and points to a file at the same address. And when you rebase and there are changes, the commit file changes, therefore it has a different hash, and is a different commit.

The last bit to know is git doesn't delete the old one until the garbage collector runs and only if the commit is over 30 days old (by default).

I hope this clarifies things for someone!
