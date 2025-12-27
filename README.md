Contract Management Tool

A simple contract management web application built with Ruby on Rails to help users manage contracts, milestones, payment terms, and invoices, with a clear financial overview and dashboard.

The goal of this project is to make it easy for users to:

Track contract progress

Know when payments are due or overdue

Understand upcoming and past invoice performance

Overview

This application follows a clear financial flow:

Contract → Milestones → Payment Terms → Invoices

A Contract has an overall value

A contract can have multiple Milestones

A contract can have multiple Payment Terms

Payment Terms determine when invoices should be issued

Invoices are issued and collected based on payment terms

Core Data Structure

Relationships in the system:

Client

has many Contracts

Contract

has many Milestones

has many Payment Terms

Payment Term

has one Invoice

Status & State Logic

Each part of the system has clear states to reflect real business conditions.

Contracts

active

inactive

Milestones

pending

completed

late

cancelled

Payment Terms

pending – conditions not met yet

overdue – conditions not met and past target date

due – conditions met, invoice not issued

invoiced – invoice issued

completed – invoice paid

Invoices

issued

outstanding

late

collected

Key Behaviors

Payment terms can be:

Manual, or

Milestone-based

If a payment term is milestone-based:

Completing the milestone automatically updates the payment term

When an invoice is issued:

The due date is automatically set to 30 days after issue

Statuses update automatically based on dates and conditions

Dashboard

The main dashboard focuses on what needs attention first.

High Priority Items

Payment Terms:

Due

Overdue

Milestones:

Late

Invoices:

Late

Upcoming Items

Invoices expected in the next:

30 days

60 days

90 days

This gives users a clear snapshot of:

Urgent actions

Upcoming cash flow

Invoice Analysis

A separate Invoice Analysis Dashboard provides:

Past month invoice performance

Expected collections in:

30 days

60 days

90 days

This is designed to support financial planning and forecasting.

Tech Stack

Ruby on Rails

SQLite (development & test)

PostgreSQL (production)

Bootstrap for UI

The UI is intentionally:

Clean

Simple

Professional

Card-based for readability

Setup
bundle install
rails db:create
rails db:migrate
rails server

Future Improvements

Potential features for future iterations:

Create contracts, milestones, payment terms, and invoices on a single page

Auto-update payment term dates when milestone dates change

Custom date ranges for:

Dashboard analytics

Invoice analysis

Main views

Validate payment terms total to 100%

Allow invoice comments from contract view

Improve navigation and back button behavior