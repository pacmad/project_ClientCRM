require 'rails_helper'

RSpec.describe ClientsController, type: :controller do

  let(:client) { create(:client) }
    
  describe 'POST #create' do
    context 'with valid attributes' do
      it 'save a new client in the database' do
        expect { post :create, params: { client: attributes_for(:client) } }.to change(Client, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { client: attributes_for(:client) }
        expect(response).to redirect_to assigns(:exposed_client)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the client' do
        expect { post :create, params: { client: attributes_for(:client, :invalid) } }.to_not change(Client, :count)
      end

      it 're-renders new view' do
        post :create, params: { client: attributes_for(:client, :invalid) }
        expect(response).to render_template :new
      end      
    end
  end

  describe 'PATCH #update' do  
    context 'with valid attributes' do
      it 'assigns the requested client to @client' do
        patch :update, params: { id: client, client: attributes_for(:client) }
        expect(assigns(:client)).to eq client
      end
           
      it 'changes client attributes' do
        patch :update, params: { id: client, client: { name: 'new name' } }
        client.reload

        expect(client.name).to eq 'new name' 
      end

      it 'redirects to updated client' do
        patch :update, params: { id: client, client: attributes_for(:client) }
        expect(response).to redirect_to client
      end
    end

    context 'with invalid attributes' do
      before { patch :update, params: { id: client, client: attributes_for(:client, :invalid) } }

      it 'does not change client' do
        client.reload
        
        expect(client.name).to eq 'MyString'
      end

      it 're-renders edit' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:client) { create(:client) }

    it 'deletes the client' do
      expect { delete :destroy, params: { id: client } }.to change(Client, :count).by(-1)
    end

    it 'redirects to index' do
      delete :destroy, params: { id: client }
      expect(response).to redirect_to clients_path
    end
  end
end