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

public class SithPerceptionPublisherStreamConfig extends StreamConfig{
	private static String sithPerceptionStreamName="sith_Perception_Analytic";
	private static String sithPerceptionStreamVersion="1.0.0";
	private static String sithPerceptionStreamDefinition=
					"{"+
					"    'name':'sith_Perception_Analytics',"+
					"    'version':'1.0.0',"+
					"    'nickName': 'Sith Analytics',"+
					"    'description': 'Sith_Perception_Analytics',"+
					"    'metaData':["+
					"        {"+
					"            'name':'ipAdd','type':'STRING'\n"+
					"        }"+
					"    ],"+
					"    'payloadData':["+
					"        {"+
					"            'name':'eventID','type':'STRING'"+
					"        },"+
					"        {"+
					"            'name':'userID','type':'STRING'"+
					"        },"+
					"		 {"+
					"            'name':'perceptionValue','type':'STRING'"+
					"        }"+
					"    ]"+
					"}";

	public SithPerceptionPublisherStreamConfig(){
		super(sithPerceptionStreamName,sithPerceptionStreamVersion,sithPerceptionStreamDefinition);
	}
}
