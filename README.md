# Project Spider Monkey [![Build Status](https://secure.travis-ci.org/andymeneely/project-spider-monkey.svg?branch=master)](https://travis-ci.org/andymeneely/project-spider-monkey) [![Version](https://github.com/andymeneely/project-spider-monkey/blob/master/build-badge.svg)](https://github.com/andymeneely/project-spider-monkey/tree/master/builds)

An open source card game, designed collaboratively.

Let's make a game the open source way. Let's submit it to [TheGameCrafter.com's "The Survival Challenge" contest](https://www.thegamecrafter.com/contests/the-survival-challenge). Due Nov 30 2015.

And no, Project Spider Monkey is not the name of the game. We can decide on the name as a team.

# Get the Game

A PDF build is always available in the `builds` folder in the repository. Be sure to pay attention to the build number (get the highest one).

The game will have two versions: a color copy and a printer-friendly black-and-white copy, called `game_color_vZZZ.pdf` and `game_bw_vZZZ.pdf` (where ZZZ is the build number).

The instructions can be found in `INSTRUCTIONS.md`.

We will also do our best to maintain "patch" PDFs, which are PDFs that have only the parts of the game that have changed from the prior version. That is, if the difference between the builds changes only a few cards, then you can print out only the new ones and update your game quickly.

For best results, I recommend getting [these sleeves](http://www.amazon.com/Clear-Sleeves-Standard-Card-Game/dp/1589945158/ref=sr_1_1?ie=UTF8&qid=1440986654&sr=8-1&keywords=card+sleeves+fantasy+flight) and cutting out your cards with a paper cutter [like this](http://www.amazon.com/Fiskars-Portable-Scrapbooking-Trimmer-196920-1001/dp/B0017KYE5Y/ref=pd_sim_201_1?ie=UTF8&refRID=1WT4X7KG510X1949037C&dpSrc=sims&dpST=_AC_UL320_SR228%2C320_). I like to put cardstock into the sleeve too to give the cards more thickness and springiness.

# Ground Rules

## Rule #1: This Game is Free

This project is free as in speech and free as in beer. We're doing this for the love of the game (literally, this game) and we're not here to make money.

**Free as in speech**: the source code in this project is licensed under the MIT License, and everything else will be under Creative Commons. See `LICENSE-MIT.txt` and `LICENSE-CC.txt` in the root and `img` folders.

**Free as in beer**: This game will always have a free print-and-play copy available online, available in  black-and-white or even full color.

There will be a storefront to purchase a nice copy of this game on TheGameCrafter. The price that is put on TheGameCrafter storefront will be the cost to manufacture the game, rounded up to the next dollar (because TGC does not allow cents to be set for prices). Any small profit (i.e. less than a dollar per game sold) will be placed into a fund that supports only this project, e.g. advertising for the game on TheGameCrafter's website. Individuals will not be compensated for their effort, and that includes me (Andy).

## Rule #2: Playtest First

Playtesting is the #1 most important need for this project. Before doing anything else on this project, print it out and playtest it. Try it out with friends, or even by yourself, and you'll understand the game much more.

When you do playtest it, be sure to record your session (see Playtest section below).

## Rule #3: Contributing Something is better than Suggesting Anything

Ideas are cheap, work is hard.

I'm sure everyone will have tons of ideas. Now I love me some good ideas. But let's be realistic: most ideas are drive-by thought experiments and are not well-reasoned design decisions. Collaboration is so much more than that.

Instead, contribute something. Write a playtest report. Revise the instructions. Do some artwork. Write up a rules variant. Add to an FAQ. Work on the box art. Do some math in the spreadsheet. Refactor the ruby code. Try out some new fonts and share what they look like. Bring the game to a local gaming club or to a game prototyping event. Write some storefront text.

Anything.

All work is appreciated. Let's be open-minded about making this the best game we can. Feel free to use the Pull Request feature on GitHub. If you contribute a few times, I'll give you collaborator access.

# Get Involved!

## Playtest

The most critical part of this project is to record feedback from our playtesting sessions. After each playtesting session, please create a new GitHub issue and call it "Playtest Build X, Y players" (where X is the game's build number, and Y is the number of players). And then provide the following:

```
How long did the game take?
What was the score?
Was the game fun?
What worked well?
What did not work so well?
Any other notes? (rules, artwork, etc.)
```

After you fill these out and submit the issue, an admin will label the issue as `playtest`. People might follow up with more specific questions, so be ready for that. Once we feel that the feedback has been factored into the next design and a new build is made, we'll close the issue.

## Contributing Artwork

The artwork on this game is primarily from http://game-icons.net. We don't have to use them completely, but that's a starting point.

If you're not Git-oriented, upload your artwork somewhere and create a GitHub issue and upload it.

If you have some Git-fu, feel free to use a pull request

1. Fork the git repository ( https://github.com/[my-github-username]/squib/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Building the Game

This project is written in Ruby, using the [Squib](https://github.com/andymeneely/squib) library to automate builds. You'll need to install those to do any new builds of your own. Here are the steps:

1. `git clone https://github.com/andymeneely/project-spider-monkey.git`
2. `cd project-spider-monkey`
3. `bundle install` (to install Squib and its dependencies)
4. `rake`

Take a look at the `Rakefile` to see how to build the various different versions.

## Contributing to the Wiki

By all means, make use of our [public wiki](https://github.com/andymeneely/project-spider-monkey/wiki) to document project needs, catalog ideas, save solo campagins, or whatever.

# Spider Monkey?!?!

That's not the name of the game. I haven't decided on a game name yet - we can decide on that as a team.

Why spider monkeys? Because they're awesome. And are even more awesome in groups.
