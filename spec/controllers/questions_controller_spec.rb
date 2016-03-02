require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

   describe 'GET #index' do

    let(:questions){FactoryGirl.create_list(:question,2)}
    before { get :index }
    it 'populates array of all Q' do 
        expect(assigns(:questions)).to match_array(questions) 
    end
    it 'renders index view' do
	expect(response).to render_template :index 
    end
   end

  describe 'GET #show' do

    let(:question){FactoryGirl.create(:question)}
    before { get :show, id: question.id }
    it 'assign requested question by ID' do 
        expect(assigns(:question)).to eq question 
    end
    it 'asigns new answer for question' do
        expect(assigns(:answer)).to be_a_new(Answer) 
    end
    
    
    it 'renders show view' do
	expect(response).to render_template :show 
    end
   end

  describe 'GET #new' do
    sign_in_user
    before { get :new }
    it 'assigned new question to question' do 
        expect(assigns(:question)).to be_a_new(Question) 
    end
    it 'renders new view' do
	expect(response).to render_template :new 
    end
   end

  describe 'GET #edit' do
    sign_in_user
    let(:question){FactoryGirl.create(:question)}
    before { get :edit , id: question}
    it 'assign requested question by ID' do 
        expect(assigns(:question)).to eq question 
    end
    it 'renders edit view' do
	expect(response).to render_template :edit 
    end
   end


  describe 'POST #create' do
    sign_in_user
    context 'with valid attr' do
	it 'save new question in db' do
	expect { post :create , question: FactoryGirl.attributes_for(:question) }.to change(Question, :count).by(1)
	end
	it 'make redirect to show view' do
	post :create , question: FactoryGirl.attributes_for(:question)
	expect(response).to redirect_to question_path(assigns(:question))
	end
	
    end
    context 'with invalid attr' do
        it 'doesnot save question' do
        	expect { post :create , question: FactoryGirl.attributes_for(:invalid_question) }.to_not change(Question, :count)
        end
        it 'rerender new view' do
        post :create , question: FactoryGirl.attributes_for(:invalid_question)
    	expect(response).to render_template :new 
        end
   end
  end
  describe 'PATCH #update' do
    sign_in_user
    let(:question){FactoryGirl.create(:question)}
    context 'valid attr' do
       it 'assign requested question to @question' do
           patch :update, id: question.id, question: FactoryGirl.attributes_for(:question)
           expect(assigns(:question)).to eq question 
       end
       it 'change question attr' do
           patch :update, id: question.id, question: {title: 'new title', body: 'new body'}
           question.reload
           expect(question.title).to eq 'new title'
           expect(question.body).to eq 'new body'
        end
       it 'rerender update view' do
        patch :update, id: question,question: FactoryGirl.attributes_for(:question)
    	expect(response).to redirect_to question
        end

    end
    context 'with invalid attr' do
        it 'doesnot change question attr' do
          patch :update, id: question.id, question: {title: 'new title', body: nil}
           question.reload
           expect(question.title).to eq 'MyString'
           expect(question.body).to eq 'MyText'
        end
        it 'rerender edit view ' do
          patch :update, id: question.id, question: {title: 'new title', body: nil}
    	expect(response).to render_template :edit 
        end
   end
    
 end
 
   describe 'DELETE #destroy' do
       sign_in_user
       let(:question){FactoryGirl.create(:question)}
       it 'delete question' do
            question
	    expect { delete :destroy, id: question }.to change(Question,:count).by(-1)
       end
       it 'rerender edit view ' do
	   delete :destroy, id: question
	   expect(response).to redirect_to questions_path
       end
   
   end
 
  

end
