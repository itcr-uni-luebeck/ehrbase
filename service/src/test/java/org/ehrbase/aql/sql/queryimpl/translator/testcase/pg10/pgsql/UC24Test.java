/*
 *  Copyright (c) 2020 Vitasystems GmbH and Christian Chevalley (Hannover Medical School).
 *
 *  This file is part of project EHRbase
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 *
 * You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing,
 *   software distributed under the License is distributed on an "AS IS" BASIS,
 *    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and  limitations under the License.
 *
 */

package org.ehrbase.aql.sql.queryimpl.translator.testcase.pg10.pgsql;

import org.ehrbase.aql.sql.queryimpl.translator.testcase.UC24;
import org.junit.Test;

import static org.assertj.core.api.Assertions.assertThat;

public class UC24Test extends UC24 {

    public UC24Test(){
        super();
        this.expectedSqlExpression =
                "select cast(\"ehr\".\"js_composition\"(cast(cast(composition_join.id as uuid) as uuid), cast(? as text)) as varchar) as \"c\" \n" +
                        "from \"ehr\".\"entry\" right outer join \"ehr\".\"composition\" as \"composition_join\" on \"composition_join\".\"id\" = \"ehr\".\"entry\".\"composition_id\"\n" +
                        " where (\"ehr\".\"entry\".\"template_id\" = ? and ((\n" +
                        "  select \"ehr\".\"entry\".\"entry\" #>> '{/composition[openEHR-EHR-COMPOSITION.health_summary.v1],/content[openEHR-EHR-ADMIN_ENTRY.hospitalization.v0],0}' \n" +
                        ")IS  NULL ))";
    }

    @Test
    public void testIt(){
        assertThat(testAqlSelectQuery()).isTrue();
    }
}
