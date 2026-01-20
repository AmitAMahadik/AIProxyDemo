//
//  ContentView.swift
//  AIProxy Demo
//
//  Created by Mahadik, Amit on 1/19/26.
//

import SwiftUI
import AIProxy

let openAIService = AIProxy.openAIService(partialKey: "v2|1bb98c48|gO7CG1rPMen7sVxe", serviceURL: "https://api.aiproxy.com/07603b96/2bbe7ff6" )

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Test OpenAI Service") {
                Task {
                    do {
                        let requestBody = OpenAIChatCompletionRequestBody(
                            model: "gpt-5.2",
                            messages: [
                                .system(content: .text("You are a friendly assistant")),
                                .user(content: .text("hello world"))
                            ],
                            reasoningEffort: .noReasoning
                        )
                        
                        do {
                            let response = try await openAIService.chatCompletionRequest(
                                body: requestBody,
                                secondsToWait: 120
                            )
                            print(response.choices.first?.message.content ?? "")
                        } catch AIProxyError.unsuccessfulRequest(let statusCode, let responseBody) {
                            print("Received \(statusCode) status code with response body: \(responseBody)")
                        } catch {
                            print("Could not create OpenAI chat completion: \(error)")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
