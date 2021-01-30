#!/bin/bash
rails runner lib/destroy_all_data.rb
rails db:seed
