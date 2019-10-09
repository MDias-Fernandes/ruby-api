require 'rails_helper'

describe V1::ContactsController, type: :controller do
    it 'response status is 200 for index' do
        request.accept = 'application/json'
        request.headers['Authorization'] = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoiTWF0aGV1cyBEaWFzIiwiZXhwIjoxNTcwNjUwMDUxfQ.3XgSlaIw81xk9Jc2WUk2ayLj4ipe8lLunS0TlsngQjM'
        get :index
        expect(response.status).to eql(200)
    end

    it 'response status is 401 for index without Bearer Token' do
        request.accept = 'application/json'
        get :index
        expect(response.status).to eql(401)
    end

    it 'GET /contacts/:id' do
        request.accept = 'application/json'
        request.headers['Authorization'] = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoiTWF0aGV1cyBEaWFzIiwiZXhwIjoxNTcwNjUwMDUxfQ.3XgSlaIw81xk9Jc2WUk2ayLj4ipe8lLunS0TlsngQjM'
        contact = Contact.find(10)
        get :show, params: {id: contact}
        response_body = JSON.parse(response.body)
        expect(response_body.fetch('data').fetch('attributes').fetch('name')).to eq(contact.name)
    end

end