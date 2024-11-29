-- CreateEnum
CREATE TYPE "AttributeType" AS ENUM ('TEXT', 'SELECT', 'NUMBER');

-- CreateEnum
CREATE TYPE "GroupType" AS ENUM ('HOMEOWNER', 'CONCIERGE', 'PRO');

-- CreateEnum
CREATE TYPE "InviteStatus" AS ENUM ('PENDING', 'EXPIRED', 'ACCEPTED');

-- CreateEnum
CREATE TYPE "MessageType" AS ENUM ('USER', 'SYSTEM', 'ASSISTANT');

-- CreateEnum
CREATE TYPE "NotificationType" AS ENUM ('EMAIL');

-- CreateEnum
CREATE TYPE "Priority" AS ENUM ('LOW', 'MEDIUM', 'HIGH', 'NONE');

-- CreateEnum
CREATE TYPE "Status" AS ENUM ('NOT_STARTED', 'IN_PROGRESS', 'COMPLETED');

-- CreateEnum
CREATE TYPE "TaskFrequency" AS ENUM ('NO_REPEAT', 'MONTHLY', 'THREE_MONTHS', 'FOUR_MONTHS', 'SIX_MONTHS', 'TWELVE_MONTHS');

-- CreateEnum
CREATE TYPE "UserRole" AS ENUM ('SUPER_ADMIN', 'GROUP_ADMIN', 'USER');

-- CreateTable
CREATE TABLE "Attribute" (
    "id" SERIAL NOT NULL,
    "templateId" TEXT,
    "label" TEXT,
    "value" TEXT NOT NULL,
    "required" BOOLEAN,
    "propertyId" INTEGER,
    "propertyFeatureId" INTEGER,
    "templateAttributeId" TEXT,
    "notes" TEXT,

    CONSTRAINT "Attribute_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Chat" (
    "id" SERIAL NOT NULL,
    "taskId" INTEGER,
    "guestTaskId" INTEGER,
    "threadId" TEXT,
    "asstEnabled" BOOLEAN,

    CONSTRAINT "Chat_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Group" (
    "id" SERIAL NOT NULL,
    "public_id" VARCHAR(14) NOT NULL,
    "name" TEXT NOT NULL,
    "type" "GroupType",

    CONSTRAINT "Group_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GroupMembership" (
    "id" SERIAL NOT NULL,
    "role" "UserRole" NOT NULL,
    "userId" INTEGER,
    "groupId" INTEGER,

    CONSTRAINT "GroupMembership_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GroupMemberAssignment" (
    "id" SERIAL NOT NULL,
    "groupMembershipId" INTEGER NOT NULL,
    "taskId" INTEGER NOT NULL,

    CONSTRAINT "GroupMemberAssignment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Guest" (
    "id" SERIAL NOT NULL,
    "public_id" VARCHAR(14) NOT NULL,
    "createdAt" TIMESTAMP(3),

    CONSTRAINT "Guest_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GuestTask" (
    "id" SERIAL NOT NULL,
    "public_id" VARCHAR(14) NOT NULL,
    "title" TEXT NOT NULL,
    "createdById" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userId" INTEGER,

    CONSTRAINT "GuestTask_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Image" (
    "id" SERIAL NOT NULL,
    "path" TEXT NOT NULL,
    "alt" TEXT,
    "propertyFeatureId" INTEGER,

    CONSTRAINT "Image_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Invite" (
    "id" SERIAL NOT NULL,
    "public_id" VARCHAR(14) NOT NULL,
    "email" TEXT NOT NULL,
    "invitedAt" TIMESTAMP(3) NOT NULL,
    "role" "UserRole" NOT NULL,
    "status" "InviteStatus" NOT NULL,
    "groupId" INTEGER,
    "propertyId" INTEGER,

    CONSTRAINT "Invite_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Message" (
    "id" SERIAL NOT NULL,
    "chatId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL,
    "authorId" INTEGER,
    "guestAuthorId" INTEGER,
    "text" TEXT NOT NULL,
    "type" "MessageType" NOT NULL DEFAULT 'USER',

    CONSTRAINT "Message_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Notification" (
    "id" SERIAL NOT NULL,
    "label" TEXT NOT NULL,
    "event" TEXT NOT NULL,
    "type" "NotificationType" NOT NULL DEFAULT 'EMAIL',

    CONSTRAINT "Notification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Password" (
    "hash" TEXT NOT NULL,
    "userId" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "Property" (
    "id" SERIAL NOT NULL,
    "public_id" VARCHAR(14) NOT NULL,
    "nickName" TEXT,
    "streetAddress" TEXT,
    "place" TEXT,
    "state" TEXT,
    "zipCode" TEXT,
    "googlePlaceId" TEXT,
    "unit" TEXT,
    "userGroupId" INTEGER,

    CONSTRAINT "Property_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PropertyFeature" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "slug" TEXT,
    "templateId" INTEGER,
    "propertyId" INTEGER,
    "category" TEXT,
    "templateFeatureId" INTEGER,
    "notes" TEXT,

    CONSTRAINT "PropertyFeature_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PropertyMembership" (
    "id" SERIAL NOT NULL,
    "role" "UserRole" NOT NULL,
    "userId" INTEGER,
    "propertyId" INTEGER,

    CONSTRAINT "PropertyMembership_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PropertyPro" (
    "id" SERIAL NOT NULL,
    "propertyId" INTEGER NOT NULL,
    "proGroupId" INTEGER NOT NULL,

    CONSTRAINT "PropertyPro_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Referral" (
    "id" SERIAL NOT NULL,
    "public_id" VARCHAR(14) NOT NULL,
    "slug" TEXT,
    "groupId" INTEGER,
    "taskId" INTEGER,

    CONSTRAINT "Referral_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Service" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "icon" TEXT NOT NULL DEFAULT 'handyman',
    "color" TEXT,
    "vendorId" INTEGER,
    "userGroupId" INTEGER,

    CONSTRAINT "Service_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Task" (
    "id" SERIAL NOT NULL,
    "public_id" VARCHAR(14) NOT NULL,
    "title" TEXT NOT NULL,
    "propertyId" INTEGER NOT NULL,
    "createdById" INTEGER,
    "assignedToId" INTEGER,
    "serviceId" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "completedAt" TIMESTAMP(3),
    "dueAt" TIMESTAMP(3),
    "scheduledAt" TIMESTAMP(3),
    "vendorId" INTEGER,
    "frequency" "TaskFrequency",
    "notes" TEXT,
    "status" "Status" NOT NULL DEFAULT 'NOT_STARTED',
    "userGroupId" INTEGER,
    "userId" INTEGER,
    "propertyProId" INTEGER,
    "priority" "Priority" DEFAULT 'NONE',

    CONSTRAINT "Task_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TaskFeature" (
    "id" SERIAL NOT NULL,
    "taskId" INTEGER NOT NULL,
    "propertyFeatureId" INTEGER NOT NULL,

    CONSTRAINT "TaskFeature_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TaskEvent" (
    "id" SERIAL NOT NULL,
    "eventDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "description" TEXT NOT NULL,
    "taskId" INTEGER,

    CONSTRAINT "TaskEvent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TemplateFeature" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "slug" TEXT,
    "icon" TEXT,
    "category" TEXT,

    CONSTRAINT "TemplateFeature_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TemplateAttribute" (
    "id" TEXT NOT NULL,
    "label" TEXT NOT NULL,
    "required" BOOLEAN,
    "type" "AttributeType" NOT NULL DEFAULT 'TEXT',
    "templateFeatureId" INTEGER,
    "placeholder" TEXT,

    CONSTRAINT "TemplateAttribute_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TemplateTask" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "frequency" "TaskFrequency" NOT NULL,
    "propertyFeatureId" INTEGER,

    CONSTRAINT "TemplateTask_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Totp" (
    "id" TEXT NOT NULL,
    "hash" TEXT NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "attempts" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "expiresAt" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Totp_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "public_id" VARCHAR(14) NOT NULL,
    "email" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "role" "UserRole" NOT NULL DEFAULT 'USER',
    "name" TEXT,
    "emailVerified" BOOLEAN NOT NULL DEFAULT false,
    "imageUrl" TEXT,
    "createdAt" TIMESTAMP(3),
    "lastLogin" TIMESTAMP(3),
    "userGroupId" INTEGER,
    "clerkId" TEXT,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserNotification" (
    "id" SERIAL NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT false,
    "userId" INTEGER,
    "notificationId" INTEGER,

    CONSTRAINT "UserNotification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Vendor" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "phone" TEXT,
    "email" TEXT,
    "userGroupId" INTEGER,

    CONSTRAINT "Vendor_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Verification" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "type" TEXT NOT NULL,
    "target" TEXT NOT NULL,
    "secret" TEXT NOT NULL,
    "algorithm" TEXT NOT NULL,
    "digits" INTEGER NOT NULL,
    "period" INTEGER NOT NULL,
    "expiresAt" TIMESTAMP(3),
    "hash" TEXT,
    "email" TEXT,
    "inviteId" TEXT,

    CONSTRAINT "Verification_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Chat_taskId_key" ON "Chat"("taskId");

-- CreateIndex
CREATE UNIQUE INDEX "Chat_guestTaskId_key" ON "Chat"("guestTaskId");

-- CreateIndex
CREATE UNIQUE INDEX "Group_public_id_key" ON "Group"("public_id");

-- CreateIndex
CREATE UNIQUE INDEX "Guest_public_id_key" ON "Guest"("public_id");

-- CreateIndex
CREATE UNIQUE INDEX "GuestTask_public_id_key" ON "GuestTask"("public_id");

-- CreateIndex
CREATE UNIQUE INDEX "Invite_public_id_key" ON "Invite"("public_id");

-- CreateIndex
CREATE UNIQUE INDEX "Notification_event_key" ON "Notification"("event");

-- CreateIndex
CREATE UNIQUE INDEX "Password_userId_key" ON "Password"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Property_public_id_key" ON "Property"("public_id");

-- CreateIndex
CREATE UNIQUE INDEX "Referral_public_id_key" ON "Referral"("public_id");

-- CreateIndex
CREATE UNIQUE INDEX "Referral_groupId_key" ON "Referral"("groupId");

-- CreateIndex
CREATE UNIQUE INDEX "Referral_taskId_key" ON "Referral"("taskId");

-- CreateIndex
CREATE UNIQUE INDEX "Task_public_id_key" ON "Task"("public_id");

-- CreateIndex
CREATE UNIQUE INDEX "TemplateAttribute_id_key" ON "TemplateAttribute"("id");

-- CreateIndex
CREATE UNIQUE INDEX "Totp_hash_key" ON "Totp"("hash");

-- CreateIndex
CREATE UNIQUE INDEX "User_public_id_key" ON "User"("public_id");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "User_username_key" ON "User"("username");

-- CreateIndex
CREATE UNIQUE INDEX "User_clerkId_key" ON "User"("clerkId");

-- CreateIndex
CREATE UNIQUE INDEX "Verification_target_type_key" ON "Verification"("target", "type");

-- AddForeignKey
ALTER TABLE "Attribute" ADD CONSTRAINT "Attribute_propertyId_fkey" FOREIGN KEY ("propertyId") REFERENCES "Property"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Attribute" ADD CONSTRAINT "Attribute_propertyFeatureId_fkey" FOREIGN KEY ("propertyFeatureId") REFERENCES "PropertyFeature"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Attribute" ADD CONSTRAINT "Attribute_templateAttributeId_fkey" FOREIGN KEY ("templateAttributeId") REFERENCES "TemplateAttribute"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Chat" ADD CONSTRAINT "Chat_taskId_fkey" FOREIGN KEY ("taskId") REFERENCES "Task"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Chat" ADD CONSTRAINT "Chat_guestTaskId_fkey" FOREIGN KEY ("guestTaskId") REFERENCES "GuestTask"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GroupMembership" ADD CONSTRAINT "GroupMembership_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GroupMembership" ADD CONSTRAINT "GroupMembership_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES "Group"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GroupMemberAssignment" ADD CONSTRAINT "GroupMemberAssignment_groupMembershipId_fkey" FOREIGN KEY ("groupMembershipId") REFERENCES "GroupMembership"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GroupMemberAssignment" ADD CONSTRAINT "GroupMemberAssignment_taskId_fkey" FOREIGN KEY ("taskId") REFERENCES "Task"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GuestTask" ADD CONSTRAINT "GuestTask_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "Guest"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GuestTask" ADD CONSTRAINT "GuestTask_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Image" ADD CONSTRAINT "Image_propertyFeatureId_fkey" FOREIGN KEY ("propertyFeatureId") REFERENCES "PropertyFeature"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Invite" ADD CONSTRAINT "Invite_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES "Group"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Invite" ADD CONSTRAINT "Invite_propertyId_fkey" FOREIGN KEY ("propertyId") REFERENCES "Property"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Message" ADD CONSTRAINT "Message_chatId_fkey" FOREIGN KEY ("chatId") REFERENCES "Chat"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Message" ADD CONSTRAINT "Message_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Message" ADD CONSTRAINT "Message_guestAuthorId_fkey" FOREIGN KEY ("guestAuthorId") REFERENCES "Guest"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Password" ADD CONSTRAINT "Password_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Property" ADD CONSTRAINT "Property_userGroupId_fkey" FOREIGN KEY ("userGroupId") REFERENCES "Group"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PropertyFeature" ADD CONSTRAINT "PropertyFeature_propertyId_fkey" FOREIGN KEY ("propertyId") REFERENCES "Property"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PropertyFeature" ADD CONSTRAINT "PropertyFeature_templateFeatureId_fkey" FOREIGN KEY ("templateFeatureId") REFERENCES "TemplateFeature"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PropertyMembership" ADD CONSTRAINT "PropertyMembership_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PropertyMembership" ADD CONSTRAINT "PropertyMembership_propertyId_fkey" FOREIGN KEY ("propertyId") REFERENCES "Property"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PropertyPro" ADD CONSTRAINT "PropertyPro_propertyId_fkey" FOREIGN KEY ("propertyId") REFERENCES "Property"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PropertyPro" ADD CONSTRAINT "PropertyPro_proGroupId_fkey" FOREIGN KEY ("proGroupId") REFERENCES "Group"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Referral" ADD CONSTRAINT "Referral_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES "Group"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Referral" ADD CONSTRAINT "Referral_taskId_fkey" FOREIGN KEY ("taskId") REFERENCES "Task"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Service" ADD CONSTRAINT "Service_vendorId_fkey" FOREIGN KEY ("vendorId") REFERENCES "Vendor"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Service" ADD CONSTRAINT "Service_userGroupId_fkey" FOREIGN KEY ("userGroupId") REFERENCES "Group"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Task" ADD CONSTRAINT "Task_propertyId_fkey" FOREIGN KEY ("propertyId") REFERENCES "Property"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Task" ADD CONSTRAINT "Task_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Task" ADD CONSTRAINT "Task_assignedToId_fkey" FOREIGN KEY ("assignedToId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Task" ADD CONSTRAINT "Task_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES "Service"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Task" ADD CONSTRAINT "Task_vendorId_fkey" FOREIGN KEY ("vendorId") REFERENCES "Vendor"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Task" ADD CONSTRAINT "Task_userGroupId_fkey" FOREIGN KEY ("userGroupId") REFERENCES "Group"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Task" ADD CONSTRAINT "Task_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Task" ADD CONSTRAINT "Task_propertyProId_fkey" FOREIGN KEY ("propertyProId") REFERENCES "PropertyPro"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TaskFeature" ADD CONSTRAINT "TaskFeature_taskId_fkey" FOREIGN KEY ("taskId") REFERENCES "Task"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TaskFeature" ADD CONSTRAINT "TaskFeature_propertyFeatureId_fkey" FOREIGN KEY ("propertyFeatureId") REFERENCES "PropertyFeature"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TaskEvent" ADD CONSTRAINT "TaskEvent_taskId_fkey" FOREIGN KEY ("taskId") REFERENCES "Task"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TemplateAttribute" ADD CONSTRAINT "TemplateAttribute_templateFeatureId_fkey" FOREIGN KEY ("templateFeatureId") REFERENCES "TemplateFeature"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TemplateTask" ADD CONSTRAINT "TemplateTask_propertyFeatureId_fkey" FOREIGN KEY ("propertyFeatureId") REFERENCES "TemplateFeature"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_userGroupId_fkey" FOREIGN KEY ("userGroupId") REFERENCES "Group"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserNotification" ADD CONSTRAINT "UserNotification_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserNotification" ADD CONSTRAINT "UserNotification_notificationId_fkey" FOREIGN KEY ("notificationId") REFERENCES "Notification"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Vendor" ADD CONSTRAINT "Vendor_userGroupId_fkey" FOREIGN KEY ("userGroupId") REFERENCES "Group"("id") ON DELETE CASCADE ON UPDATE CASCADE;

