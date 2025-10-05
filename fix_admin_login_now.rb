#!/usr/bin/env ruby
# Quick fix for admin login issue
require_relative 'config/environment'

puts "🔧 Fixing admin login issue..."

# Find or create admin user
admin_email = 'admin@example.com'
admin_password = 'spree123'

begin
  # Delete existing admin if exists (check both User and AdminUser)
  existing_user = Spree::User.find_by(email: admin_email)
  if existing_user
    existing_user.destroy
    puts "🗑️ Deleted existing user"
  end

  existing_admin = Spree::AdminUser.find_by(email: admin_email)
  if existing_admin
    existing_admin.destroy
    puts "🗑️ Deleted existing admin user"
  end

  # Create new admin user using the correct Spree::AdminUser model
  admin = Spree::AdminUser.create!(
    email: admin_email,
    password: admin_password,
    password_confirmation: admin_password
  )

  puts "✅ Created new admin user:"
  puts "   Email: #{admin_email}"
  puts "   Password: #{admin_password}"
  puts "   Admin URL: http://localhost:3001/admin"
  puts ""
  puts "🌐 Now try logging in at: http://localhost:3001/admin"
  puts "   Email: #{admin_email}"
  puts "   Password: #{admin_password}"

rescue => e
  puts "❌ Error creating admin user: #{e.message}"
  puts "Backtrace: #{e.backtrace.first(5).join("\n")}"
end
