class MainController < ApplicationController
    def index
        response = {
            title: "API Endpoints",
            contents: [
                {
                    method: "POST",
                    url: "/orders",
                    description: "for insert new order",
                    payload: {
                        customerId: 1,
                        customerName: "name",
                        orderId: "123",
                        totalInCents: 100,
                        date: "2022-03-04T05:29:29.850Z"
                    }
                },
                {
                    method: "GET",
                    url: "/customers/:id",
                    description: "for getting customer detail with id selected",
                    payload: {}
                },
                {
                    method: "GET",
                    url: "/customers/:id/orders",
                    description: "for getting customer's orders",
                    payload: {
                        page: 1,
                        per: 10,
                    }
                }
            ]
        }
        render json: response
    end
end
