/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.sith.cep.publisher;

import org.sith.cep.publisher.config.SithPerceptionPublisherStreamConfig;
import org.sith.cep.publisher.config.StreamConfig;
import org.wso2.carbon.databridge.agent.thrift.DataPublisher;
import org.wso2.carbon.databridge.agent.thrift.exception.AgentException;
import org.wso2.carbon.databridge.commons.exception.*;

import java.net.MalformedURLException;

public class SithCEPPublisher{
	private DataPublisher dataPublisher;
	private StreamConfig streamConfig;

	public SithCEPPublisher(String url, String userName, String password){
		//KeyStoreUtil.setTrustStoreParams();
		System.setProperty("javax.net.ssl.trustStore","wso2carbon.jks");
		System.setProperty("javax.net.ssl.trustStorePassword", "wso2carbon");

		System.out.println("Key Store is set..");
		//according to the convention the authentication port will be 7611+100= 7711 and its host will be the same

		try{
			dataPublisher = new DataPublisher(url, userName, password);
		}catch(MalformedURLException e){
			e.printStackTrace();
		}catch(AgentException e){
			e.printStackTrace();
		}catch(AuthenticationException e){
			e.printStackTrace();
		}catch(TransportException e){
			e.printStackTrace();
		}
		System.out.println("Logged in..");

		this.streamConfig=new SithPerceptionPublisherStreamConfig();
		System.out.println("Default Stream Config Added..");
	}

	public SithCEPPublisher(String url, String userName, String password,String streamName, String streamVersion, String streamDefinition){
		//KeyStoreUtil.setTrustStoreParams();
		System.setProperty("javax.net.ssl.trustStore","wso2carbon.jks");
		System.setProperty("javax.net.ssl.trustStorePassword", "wso2carbon");

		System.out.println("Key Store is set..");
		//according to the convention the authentication port will be 7611+100= 7711 and its host will be the same

		try{
			dataPublisher = new DataPublisher(url, userName, password);
		}catch(MalformedURLException e){
			e.printStackTrace();
		}catch(AgentException e){
			e.printStackTrace();
		}catch(AuthenticationException e){
			e.printStackTrace();
		}catch(TransportException e){
			e.printStackTrace();
		}
		System.out.println("Logged in..");

		this.streamConfig=new StreamConfig(streamName,streamVersion,streamDefinition);
		System.out.println("Stream Config Added..");
	}

	public String publishToCEP(Object[] metaDataArray,Object[] payloadArray) {

		System.out.println("Starting publishing process..");

		String streamId;
		try {
			streamId = dataPublisher.findStream(streamConfig.getStreamName(), streamConfig.getStreamVersion());
		} catch (NoStreamDefinitionExistException e) {
			try{
				streamId = dataPublisher.defineStream(streamConfig.getStreamDefinition());
				System.out.println("Stream Definition created..");
			}catch(AgentException e1){
				e1.printStackTrace();
				return "Failed";
			}catch(MalformedStreamDefinitionException e1){
				e1.printStackTrace();
				return "Failed";
			}catch(StreamDefinitionException e1){
				e1.printStackTrace();
				return "Failed";
			}catch(DifferentStreamDefinitionAlreadyDefinedException e1){
				e1.printStackTrace();
				return "Failed";
			}

		}catch(StreamDefinitionException e){
			e.printStackTrace();
			return "Failed";
		}catch(AgentException e){
			e.printStackTrace();
			return "Failed";
		}
		System.out.println("Stream created..");

		try{
			//dataPublisher.publish(streamId, new Object[]{ipAddress}, null, new Object[]{eventID, userID, percetionValue});
			dataPublisher.publish(streamId, metaDataArray, null, payloadArray);

		}catch(AgentException e){
			e.printStackTrace();
			return "Failed";
		}
		System.out.println("Data published..");

		return "Done";
	}
}