# Role-Based Software Installation and Access Grant Policy

## The Problem This Policy Exists to Solve

Access requests that should take one day take two weeks for one reason: nobody
planned them before day one.

The new joiner discovers they need repository access on day two. They request it,
wait three days, then discover they also need VPN. They request that, wait again,
then discover the bespoke tool they need requires a service portal request that must
come from their manager. The manager was not told. Three more days pass. Each
discovery triggers a new wait. The waits are serial. The total is two weeks or more.

This is not an IT problem. IT processes requests in the order they arrive. The
problem is that requests arrive one at a time, days apart, instead of all at once
before day one.

This policy defines what each role needs, who grants it, and - critically - when
requests must be submitted so that waits run in parallel rather than in series.

---

## The Dependency Ordering Principle

Some access depends on other access being in place first. Requests submitted in the
wrong order create unavoidable serial waits.

**Mandatory pre-conditions:**

1. Work email account must exist before anything else. Most systems require a
   corporate email to provision access.
2. Device must be provisioned before software can be installed.
3. VPN must be active before internal systems (repositories, wikis, dashboards)
   can be reached from outside the office.
4. Service portal account must exist before bespoke software can be requested.

**Rule:** The manager submits all requests simultaneously on the day the role is
confirmed, not on day one. Items with pre-conditions should be submitted in the
order above. Items without pre-conditions are submitted in parallel.

---

## Access Tiers

Every access item falls into one of three tiers based on when the new joiner needs
it and what it depends on.

| Tier | When needed | Submitted by | Submitted when |
|------|-------------|-------------|----------------|
| Pre-provision | Before day one | Manager / IT | On role confirmation |
| Day-one | By end of day one | Manager on behalf of new joiner | Day one morning |
| Week-one | During week one | New joiner self-service or manager | Day one, expected resolution within 5 days |

If a Tier 1 item is not ready on day one, escalate immediately. Do not wait.

---

## Role Catalog

Add, remove, or rename roles to match your organisation. Each role lists its
required software and access by tier.

---

### Software Engineer / Developer

**Tier 1 - Pre-provision (before day one)**

| Item | Category | Who Grants | Notes |
|------|----------|-----------|-------|
| Work laptop (provisioned, OS installed, wiped to baseline) | Hardware | IT | Order 2+ weeks ahead |
| Work email account | Identity | IT | Required before all other provisioning |
| Building access pass | Physical | Facilities | |
| Corporate SSO / identity provider account | Identity | IT | Gate for most other access |

**Tier 2 - Day-one requests (submit on day one, expect resolution within 48 hours)**

| Item | Category | Who Grants | Notes |
|------|----------|-----------|-------|
| Code repository access (GitHub / GitLab / Azure DevOps) | Source control | Engineering manager | Specify repos by name |
| IDE licence (JetBrains / Visual Studio / VS Code) | Software | IT or manager | Some are free; licence required for commercial IDEs |
| Team communication tool (Teams / Slack) | Communication | IT or self-service | Add to correct channels - see ROLE-ACCESS-POLICY role section |
| VPN client and credentials | Network | IT | Required for remote access to internal systems |
| Wiki / documentation access (Confluence / Notion / SharePoint) | Documentation | IT or self-service | |
| Issue tracker access (Jira / Azure Boards / Linear) | Project management | Engineering manager | Assign to correct project/board |
| CI/CD pipeline read access | Build | Engineering manager or DevOps | Write access may follow after onboarding |

**Tier 3 - Week-one requests (submit day one, expect resolution within 5 days)**

| Item | Category | Who Grants | Notes |
|------|----------|-----------|-------|
| Bespoke / specialist software (via service portal) | Software | IT via service portal | Manager must submit; new joiner cannot self-request on day one |
| Cloud platform console access (AWS / Azure / GCP) | Infrastructure | Cloud admin | Specify which account and permission level |
| Database read access (non-production) | Data | DBA or engineering manager | Specify database and environment |
| Package registry access (npm / NuGet / Maven) | Dependency management | IT or self-service | |
| Monitoring / observability dashboard access (Grafana / Datadog) | Observability | Engineering manager or DevOps | |

---

### QA / Test Engineer

**Tier 1 - Pre-provision**

Same as Software Engineer.

**Tier 2 - Day-one requests**

| Item | Category | Who Grants | Notes |
|------|----------|-----------|-------|
| Code repository read access | Source control | Engineering manager | QA typically needs read; write access on request |
| Team communication tool | Communication | IT or self-service | |
| VPN client | Network | IT | |
| Test management tool access (Zephyr / TestRail / Xray) | Testing | Engineering manager | |
| Issue tracker access | Project management | Engineering manager | |
| Wiki / documentation access | Documentation | IT or self-service | |

**Tier 3 - Week-one requests**

| Item | Category | Who Grants | Notes |
|------|----------|-----------|-------|
| Non-production environment access | Environments | DevOps or engineering manager | Test, staging environments |
| Test data access | Data | DBA or engineering manager | Must comply with data protection policy |
| Bespoke test tooling (via service portal) | Software | IT via service portal | |
| Performance / load testing tools | Testing | IT or self-service | |

---

### DevOps / Platform / Infrastructure Engineer

**Tier 1 - Pre-provision**

Same as Software Engineer.

**Tier 2 - Day-one requests**

| Item | Category | Who Grants | Notes |
|------|----------|-----------|-------|
| Code repository access | Source control | Engineering manager | |
| Infrastructure-as-code repository access | Source control | Engineering manager | |
| VPN client and credentials | Network | IT | |
| Team communication tool | Communication | IT or self-service | |
| CI/CD pipeline full access | Build | Senior DevOps or manager | |
| Cloud platform read access | Infrastructure | Cloud admin | Write access follows after onboarding |

**Tier 3 - Week-one requests**

| Item | Category | Who Grants | Notes |
|------|----------|-----------|-------|
| Cloud platform write / deployment access | Infrastructure | Cloud admin | Specify scope: which accounts, environments |
| Production environment read access | Infrastructure | Cloud admin or manager | View-only; write access requires separate approval |
| Secrets management access (Vault / AWS Secrets Manager) | Security | Security team or manager | Scoped to role; document which secrets |
| Container registry access | Build | DevOps lead | |
| Monitoring and alerting tool admin access | Observability | DevOps lead | |
| Bespoke infrastructure tooling (via service portal) | Software | IT via service portal | |

---

### Product Manager / Business Analyst

**Tier 1 - Pre-provision**

Same hardware and email provisioning as engineering roles.

**Tier 2 - Day-one requests**

| Item | Category | Who Grants | Notes |
|------|----------|-----------|-------|
| Issue tracker access with PM-level permissions | Project management | Engineering manager or PM lead | |
| Team communication tool | Communication | IT or self-service | |
| Wiki / documentation access with edit rights | Documentation | IT or manager | |
| VPN client | Network | IT | |
| Analytics / reporting dashboard access | Data | Data team or manager | |

**Tier 3 - Week-one requests**

| Item | Category | Who Grants | Notes |
|------|----------|-----------|-------|
| Customer data access (anonymised / aggregated) | Data | Data team | Must comply with data protection policy |
| Roadmap tool access (Productboard / Aha! / Miro) | Planning | Manager or self-service | |
| Code repository read access | Source control | Engineering manager | Read-only for context |
| Bespoke PM tooling (via service portal) | Software | IT via service portal | |

---

### Engineering Manager / Team Lead

**Tier 1 - Pre-provision**

Same as Software Engineer, plus HR system access if managing headcount or expenses.

**Tier 2 - Day-one requests**

| Item | Category | Who Grants | Notes |
|------|----------|-----------|-------|
| Code repository admin access for team repos | Source control | Senior engineering manager | |
| Team communication tool | Communication | IT or self-service | |
| VPN client | Network | IT | |
| Issue tracker with admin/team management rights | Project management | PM lead or IT | |
| HR system access (if applicable) | HR | HR | Manage leave, performance records |
| On-call / incident management tool access | Operations | DevOps or IT | |

**Tier 3 - Week-one requests**

| Item | Category | Who Grants | Notes |
|------|----------|-----------|-------|
| Budget / procurement system access | Finance | Finance team | If manager holds budget |
| Vendor / service portal admin access | Procurement | IT | To submit access requests on behalf of team |
| Cloud platform with billing visibility | Infrastructure | Cloud admin | Read-only billing access |

---

## Service Portal Guidance

Most bespoke or specialist software requires a formal request through the
organisation's IT service portal. The following rules apply:

1. **The manager submits service portal requests, not the new joiner.** The new
   joiner does not yet have a service portal account and cannot navigate the system
   on day one.
2. **Submit all service portal requests on the day the role is confirmed,** not on
   day one. Service portal requests can take 5-10 working days.
3. **Use the role access checklist** from this policy as the basis for the request.
   Submit all Tier 3 items at once, not individually as they are discovered.
4. **Record every submitted request** in Table 2 of the Journey Recorder with the
   request reference number, submission date, and expected resolution date.
5. **Follow up on outstanding requests at the 5-day mark.** If a request has not
   been resolved within 5 working days of submission, escalate to the IT manager
   with the request reference number.

---

## Request SLAs

These are target resolution times from the point the request is correctly submitted.

| Access type | Target resolution |
|-------------|------------------|
| Email account creation | 1 working day |
| Hardware delivery (standard) | 5-10 working days |
| Hardware delivery (bespoke / specialist) | 15-20 working days |
| Building access | 2 working days |
| Repository and tool access (self-service) | Same day |
| Repository and tool access (requires approval) | 1-2 working days |
| VPN access | 1-2 working days |
| Cloud platform access | 2-5 working days |
| Bespoke software via service portal | 5-10 working days |

If an SLA is missed, the manager escalates to the responsible team's lead. The
Journey Recorder records the escalation date and outcome.

---

## Access Review and Offboarding

Access is not permanent. Two reviews apply:

**Annual access review:** Every 12 months, managers review Table 2 of each team
member's Journey Recorder (or its equivalent audit record) and confirm that all
access granted is still required for the current role. Access no longer required
is revoked.

**Offboarding:** When a person leaves the organisation, all access must be revoked
within one working day of their last day. The manager is responsible for notifying
IT with the full list of granted access. "Full list" means every item in Table 2
of the person's Journey Recorder, which is why the Journey Recorder must be kept
current throughout employment.

Access left active after a person leaves is a security incident, not an
administrative oversight.

---

## References

- [ONBOARDING-POLICY.md](ONBOARDING-POLICY.md) - onboarding process and manager responsibilities
- [Onboarding-Journey-Recorder.md](../Templates/Onboarding-Journey-Recorder.md) - per-joiner tracking
- [BEST-ENGINEERING-POLICY.md](BEST-ENGINEERING-POLICY.md) - engineering standards new joiners must be briefed on
