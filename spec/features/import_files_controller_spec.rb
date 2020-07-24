require 'rails_helper'

RSpec.feature 'Widget management', :type => :feature do
  let!(:file) { Rails.root.join('spec', 'data', 'cnab_example.txt') }

  feature 'Visitors visit /' do
    before do
      visit root_path
    end

    scenario 'visitor in /' do
      expect(page).to have_content('Informe o arquivo CNAB')
    end

    scenario 'Visitors interact with page' do
      attach_file "import_file_file", file, make_visible: true
      click_button 'Salvar dados'
      expect(page).to have_content('Importação realizada com sucesso')
    end
  end
end
