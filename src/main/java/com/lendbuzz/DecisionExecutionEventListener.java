package com.lendbuzz;

import org.kie.dmn.api.core.event.BeforeEvaluateDecisionEvent;
import org.kie.dmn.api.core.event.DMNRuntimeEventListener;
import org.kie.dmn.api.core.event.AfterEvaluateDecisionEvent;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class DecisionExecutionEventListener implements DMNRuntimeEventListener {

    @Value("${application.version}")
    private String version;

    @Override
    public void beforeEvaluateDecision(BeforeEvaluateDecisionEvent event) {
        // No-op
    }

    @Override
    public void afterEvaluateDecision(AfterEvaluateDecisionEvent event) {
        event.getResult().getContext().set("version", version);
    }
}