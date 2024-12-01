require 'rails_helper'

RSpec.describe ContentFile, type: :model do
  describe 'Validações' do
    context 'quando ContentFile é válido' do
      it 'com todos os atributos preenchidos' do
        expect { create(:content_file, :com_arquivo_csv) }.to change(described_class, :count).by(1)
      end
    end
    context 'quando ContentFile não é válido' do
      it 'sem content_file_name' do
        content_file = build(:content_file, :com_arquivo_csv, content_file_name: nil)
        content_file.valid?
        expect(content_file.errors[:content_file_name]).to include('não pode ficar em branco')
      end

      it 'sem arquivo' do
        content_file = build(:content_file, file_data: nil)
        content_file.valid?
        expect(content_file.errors[:file_data]).to include('não pode ficar em branco')
      end

      it 'arquivo com outro diferente de CSV' do
        content_file = build(:content_file, :com_arquivo_em_outro_formato)
        content_file.valid?
        expect(content_file.errors[:file_data]).to include(I18n.t('activerecord.errors.models.content_file.' +
                                                                          'attributes.file_data.tipo_arquivo_nao_permitido'))
      end
    end
  end
end
