def find_or_create_admin
  Admin.first || create(:admin)
end