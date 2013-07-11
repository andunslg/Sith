/**
 Licensed to the Apache Software Foundation (ASF) under one or more
 contributor license agreements.  See the NOTICE file distributed with
 this work for additional information regarding copyright ownership.
 The ASF licenses this file to You under the Apache License, Version 2.0
 (the "License"); you may not use this file except in compliance with
 the License.  You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 **/
package org.sith.cep.publisher;

import org.wso2.carbon.databridge.agent.thrift.DataPublisher;
import org.wso2.carbon.databridge.agent.thrift.exception.AgentException;
import org.wso2.carbon.databridge.commons.exception.*;
import org.wso2.carbon.databridge.core.exception.DataBridgeException;

import java.net.MalformedURLException;

public class PerceptionPublisher {

	public String publishToCEP(String ipAddress,String eventID,String userID,String percetionValue) throws DataBridgeException, AgentException, MalformedURLException,
			AuthenticationException, TransportException, MalformedStreamDefinitionException,
			StreamDefinitionException, DifferentStreamDefinitionAlreadyDefinedException,
			InterruptedException{

		System.out.println("Starting publishing process..");
		//KeyStoreUtil.setTrustStoreParams();
		System.setProperty("javax.net.ssl.trustStore","wso2carbon.jks");
		System.setProperty("javax.net.ssl.trustStorePassword", "wso2carbon");

		System.out.println("Key Store is set..");
		//according to the convention the authentication port will be 7611+100= 7711 and its host will be the same

		DataPublisher dataPublisher = new DataPublisher("tcp://localhost:7611", "admin", "admin");
		System.out.println("Logged in..");

		String streamId;
		try {
			streamId = dataPublisher.findStream("sith_Perception_Analytic", "1.0.0");
		} catch (NoStreamDefinitionExistException e) {
			streamId = dataPublisher.defineStream("{\n"+
					"    \"name\":\"sith_Perception_Analytics\",\n"+
					"    \"version\":\"1.0.0\",\n"+
					"    \"nickName\": \"Sith Analytics\",\n"+
					"    \"description\": \"Sith_Perception_Analytics\",\n"+
					"    \"metaData\":[\n"+
					"        {\n"+
					"            \"name\":\"ipAdd\",\"type\":\"STRING\"\n"+
					"        }\n"+
					"    ],\n"+
					"    \"payloadData\":[\n"+
					"        {\n"+
					"            \"name\":\"eventID\",\"type\":\"STRING\"\n"+
					"        },\n"+
					"        {\n"+
					"            \"name\":\"userID\",\"type\":\"STRING\"\n"+
					"        },\n"+
					"\t{\n"+
					"            \"name\":\"perceptionValue\",\"type\":\"STRING\"\n"+
					"        }\n"+
					"    ]\n"+
					"}");

		}

		System.out.println("Stream created..");

		//In this case correlation data is null
		dataPublisher.publish(streamId, new Object[]{ipAddress}, null, new Object[]{eventID, userID, percetionValue});

		System.out.println("Data published..");

		return "Done";
	}
}