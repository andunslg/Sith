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
package org.sith.cep.publisher.config;

public class StreamConfig{

	private String streamName;
	private String streamVersion;
	private String streamDefinition;

	public StreamConfig(String streamName, String streamVersion, String streamDefinition){
		this.streamName=streamName;
		this.streamVersion=streamVersion;
		this.streamDefinition=streamDefinition;
	}

	public String getStreamName(){
		return streamName;
	}

	public void setStreamName(String streamName){
		this.streamName=streamName;
	}

	public String getStreamVersion(){
		return streamVersion;
	}

	public void setStreamVersion(String streamVersion){
		this.streamVersion=streamVersion;
	}

	public String getStreamDefinition(){
		return streamDefinition;
	}

	public void setStreamDefinition(String streamDefinition){
		this.streamDefinition=streamDefinition;
	}
}
