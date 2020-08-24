# RaffleEspresso Setup Guide

# For RaffleEspresso To Work Correctly:
  The User MUST sign into each of their emails and TURN ON 'ALLOW LESS SECURE APPS gmail account settings.
  Only required to do this once for each email.

# Ruby on Rails Environment Set Up

Ruby Version: '2.6.6'

Rails Version: 6.0.3

$ brew install rbenv

$ rbenv init

$ rbenv install 2.6.6

$ rvm use 2.6.6


Bundler

$ gem install bundler


Setup

Clone the repo

git clone https://github.com/anakos9/RaffleEspresso.git

Install required gems

$ bundle install

Create a .env file

$ touch .env

Run local server

rails s (in one terminal tab)

Run program

- Navigate to RaffleEspresso/apps/clients

- Once in folder (and rails s server is on)

- Run command: create_raffle_entries.exe 

- This will initialize the program and you can begin making entries!


