import type { MetaFunction } from "@remix-run/node";
import { BODY, HEADING_3 } from "../styles/typography";
import { Icon } from "../components/Icon/Icon";

export const meta: MetaFunction = () => {
  return [{ title: "Starling Home" }];
};

export default function Dashboard() {
  return (
    <>
      <div className="mb-3 mt-4 flex flex-col gap-4 px-4 md:mt-6 md:gap-6 md:px-6">
        <div className="flex flex-col gap-4 md:flex-row md:gap-6">
          {/* <Metric
            label="Completed This Month"
            value={completedThisMonthCount.toString()}
          />
          <Metric
            label="Due This Month"
            value={String(thisMonthCount + overdueCount)}
          />
          <Metric label="Clients" value={proPropertyCount.toString()} /> */}
        </div>
        <div className="flex flex-col-reverse overflow-hidden rounded bg-beige p-4 md:flex-row md:p-6">
          <div className="flex flex-1 flex-col gap-3">
            <h2 className={HEADING_3}>Build your client list</h2>
            <p className={BODY}>
              Share your referral link to onboard more homeowners to your client
              list.
            </p>
            <div>
              <Icon iconName="search" />
            </div>
            <div>
              <Icon iconName="delete" iconStyles="text-blue-500  text-4xl" />
            </div>
          </div>
        </div>
      </div>
    </>
  );
}
